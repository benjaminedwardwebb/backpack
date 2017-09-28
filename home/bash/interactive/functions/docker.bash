# global docker function
# calling docker with 0 arguments in any directory will
# - execute ./docker if one exists in the pwd
# - execute "docker-compose up" if a docker-compose file exists in the pwd
# - execute docker build & run if a Dockerfile exists in the pwd
# - execute regular "docker" otherwise
if dependency docker; then

  __docker_executable="$(which docker)"

  function __docker_default_command {
    $__docker_executable build --iidfile ./image-id .
    local image_id="$(cat ./image-id)"
    $__docker_executable run \
      -p 127.0.0.1:80:80 \
      -p 127.0.0.1:443:443 \
      $image_id
    rm ./image-id
  }

  __docker_compose_exists=false
  if dependency docker-compose; then
    __docker_compose_exists=true
    __docker_compose_executable="$(which docker-compose)"
    function __docker_compose_default_command {
      $__docker_compose_executable up
    }
  fi

  function docker {
    local args="$@"

    if [ "$args" ]; then $__docker_executable $args;
    else
      local docker_local_executable_script_exists=false
      if [ -e ./docker ]; then docker_local_executable_script_exists=true; fi

      local docker_compose_file_exists=false
      if [ -e ./docker-compose.yml ] || [ -e ./docker-compose.yaml ]; then docker_compose_file_exists=true; fi

      local docker_file_exists=false
      if [ -e ./Dockerfile ]; then docker_file_exists=true; fi
      
      if [ "$docker_local_executable_script_exists" = true ]; then ./docker
      elif [ "$docker_compose_file_exists" = true ] && [ "$__docker_compose_exists" = true ]; then __docker_compose_default_command
      elif [ "$docker_file_exists" = true ]; then __docker_default_command
      else $__docker_executable
      fi
    fi
  }

fi
