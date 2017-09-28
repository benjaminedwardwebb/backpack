from dataclasses import dataclass
from pathlib import Path
from returns.io import IO, IOSuccess, IOResultE, impure_safe
from returns.maybe import Maybe, Some, Nothing
from returns.pipeline import flow
from returns.pointfree import bind, bind_io, map_
from returns.unsafe import unsafe_perform_io
from typing import Callable, TextIO, List
import logging
import json
import os

logging.basicConfig(level="INFO")
logger = logging.getLogger(__name__)

def main() -> None:
    return unsafe_perform_io(program())


def program() -> IO[None]:
    return flow(
        load_vimium_options_template(),
        bind(set_search_engines),
        bind(set_key_mappings),
        bind(set_user_defined_link_hint_css),
        bind(write_vimium_options)
    )


def load_vimium_options_template() -> IO[dict]:
    path = Path("vimium-options.template.json")
    def load_dict(string: str) -> dict:
        return json.loads(string)
    return flow(
        read_file_as_string(path),
        map_(load_dict)
    )


# TODO vimium: Do we need to handle defaults in the bookmark class?
@dataclass
class Bookmark:
    keyword: str
    name: str
    url: str


def deserialize_bookmark(dict: dict) -> Bookmark:
    return Bookmark(
        dict["keyword"],
        dict["name"],
        dict["url"]
    )


def set_search_engines(vimium_options: dict) -> IO[dict]:
    def get_bookmarks() -> IO[list[Bookmark]]:
        name = "bookmarks.json"
        def read_file(path: Path) -> IO[Maybe[str]]:
            ioresult = read_file_as_string(path)
            maybe: Maybe[str]
            if isinstance(ioresult, IOSuccess):
                io = ioresult.unwrap()
                string = unsafe_perform_io(io)
                maybe = Some(string)
            else:
                logger.info(f"Failed to read file at {path}.")
                maybe = Nothing
            return IO(maybe)
        def load_bookmarks(maybe: Maybe[str]) -> list[Bookmark]:
            list: List[Bookmark]
            if isinstance(maybe, Some):
                string = maybe.unwrap()
                list = json.loads(string, object_hook=deserialize_bookmark)
            else:
                list = []
            return list
        return flow(
            get_firefox_data_file_path(name),
            bind(read_file),
            map_(load_bookmarks)
        )

    def transform_to_search_engines(bookmarks: list[Bookmark]) -> str:
        def transform(bookmark: Bookmark) -> str:
            return f"{bookmark.keyword}: {bookmark.url} {bookmark.name}"

        return "\n".join(map(transform, bookmarks))

    def set_search_engines(str: str) -> dict:
        vimium_options["searchEngines"] = str
        return vimium_options

    return flow(
        get_bookmarks(),
        map_(transform_to_search_engines),
        map_(set_search_engines)
    )


def set_key_mappings(vimium_options: dict) -> IO[dict]:
    name = "keyMappings.vim"

    def set_key_mappings(str: str) -> dict:
        vimium_options["keyMappings"] = str
        return vimium_options

    return flow(
        get_vimium_config_file_path(name),
        bind(read_file_as_string),
        lambda ioresult: ioresult.unwrap(),
        map_(set_key_mappings)
    )


def set_user_defined_link_hint_css(vimium_options: dict) -> IO[dict]:
    name = "userDefinedLinkHintCss.css"

    def set_user_defined_link_hint_css(str: str) -> dict:
        vimium_options["userDefinedLinkHintCss"] = str
        return vimium_options

    return flow(
        get_vimium_config_file_path(name),
        bind(read_file_as_string),
        lambda ioresult: ioresult.unwrap(),
        map_(set_user_defined_link_hint_css)
    )


def write_vimium_options(vimium_options: dict) -> IO[None]:
    name = "vimium-options.json"
    def serialize(dict: dict) -> str:
        # The JSON file created by vimium's backup button is pretty-printed
        # with keys indented by two spaces.
        return json.dumps(dict, indent=2)
    def write_file(string: str) -> IO[None]:
        return flow(
            get_vimium_data_file_path(name),
            bind(lambda path: write_string_to_file(string, path))
        )
            
    return flow(
        serialize(vimium_options),
        write_file
    )


@impure_safe
def read_file_as_string(path: Path) -> str:
    string = None
    with path.open() as file:
        string = file.read()
    return string


def write_string_to_file(string: str, path: Path) -> IO[int]:
    def write_file(string: str, path: Path) -> int:
        number_of_characters_written = None
        with path.open("w") as file:
            number_of_characters_written = file.write(string)
        return number_of_characters_written
    return IO(write_file(string, path))


def get_vimium_data_file_path(name: str) -> IO[Path]:
    def get_path(directory: str) -> Path:
        return get_vimium_file_path(directory, name)
    def make_parent_directory(path: Path) -> IO[Path]:
        def mkdir_p(path: Path) -> Path:
            if not path.parent.exists():
                logger.info(f"Making directory {path.parent}.")
            path.parent.mkdir(parents = True, exist_ok = True)
            return path
        return IO(mkdir_p(path))
    return flow(
        xdg_data_home(),
        map_(get_path),
        bind(make_parent_directory)
    )


def get_vimium_config_file_path(name: str) -> IO[Path]:
    def get_path(directory: str) -> Path:
        return get_vimium_file_path(directory, name)
    return flow(
        xdg_config_home(),
        map_(get_path)
    )


def get_vimium_file_path(directory: str, name: str) -> Path:
    return Path(f"{directory}/firefox/vimium/{name}")


def get_firefox_data_file_path(name: str) -> IO[Path]:
    def get_path(directory: str) -> Path:
        return Path(f"{directory}/firefox/{name}")
    return flow(
        xdg_data_home(),
        map_(get_path)
    )


def xdg_data_home() -> IO[str]:
    def default() -> str:
        path = Path.home().joinpath(".local", "share")
        return str(path)
    string = os.getenv("XDG_DATA_HOME", default())
    return IO(string)

# TODO vimium: Rename this function, since it now returns a path like ~/backpack/firefox/.config instead of ~/.config.
# See: https://stackoverflow.com/a/595332/8732788
def xdg_config_home() -> IO[str]:
    #return IO(os.getenv("XDG_CONFIG_HOME", "~/.config"))
    string = os.path.realpath(__file__)
    path = Path(string).parent.parent.parent
    string = str(path)
    return IO(string)


if __name__ == "__main__":
    main()
