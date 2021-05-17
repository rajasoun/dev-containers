#!/usr/bin/env bats

load '../common/libs'

profile_script="./src/lib/os.bash"

setup() {
    echo "SetUp"
    # shellcheck disable=SC1090
    source ${profile_script}
}

teardown() {
  echo "Teardown"
}


@test ".unit.os._create_directory_if_not_exists For Empty Directory Name" {
  # shellcheck disable=SC1090
  run _create_directory_if_not_exists ""
  assert_failure
}

@test ".unit.os._display_time - diaplays 60 seconds in mins and seconds" {
    run _display_time 60
    assert_output --partial "1 minutes and 0 seconds"
}

@test ".unit.os._display_time - diaplays 0 seconds in mins and seconds" {
    run _display_time 0
    assert_output --partial "0 seconds"
}

@test ".unit.os._file_contains_text - Checks if text 'Displays Time'  exists in  ./src/lib/os.bash File" {
    run _file_contains_text "Displays Time" ${profile_script}
    assert_success
}

@test ".unit.os._file_contains_text - Checks if text 'SHOULD_NOT_EXIST' NOT exists in  ./src/lib/os.bash File" {
    run file_contains_text "SHOULD_NOT_EXIST" ${profile_script}
    assert_failure
}

@test ".unit.os._file_replace_text empty file" {
  # shellcheck disable=SC2155
  local readonly tmp_file=$(mktemp)
  local readonly original_regex="foo"
  local readonly replacement="bar"

  run _file_replace_text "$original_regex" "$replacement" "$tmp_file"
  assert_success

  # shellcheck disable=SC2155
  local readonly actual=$(cat "$tmp_file")
  local readonly expected=""
  assert_equal "$expected" "$actual"

  rm -f "$tmp_file"
}

@test ".unit.os._file_replace_text non empty file, no match" {
  # shellcheck disable=SC2155
  local readonly tmp_file=$(mktemp)
  local readonly original_regex="foo"
  local readonly replacement="bar"
  local readonly file_contents="not a match"

  echo "$file_contents" > "$tmp_file"

  run _file_replace_text "$original_regex" "$replacement" "$tmp_file"
  assert_success

  # shellcheck disable=SC2155
  local readonly actual=$(cat "$tmp_file")
  local readonly expected="$file_contents"
  assert_equal "$expected" "$actual"

  rm -f "$tmp_file"
}

@test ".unit.os._file_replace_text non empty file, exact match" {
  # shellcheck disable=SC2155
  local readonly tmp_file=$(mktemp)
  local readonly original_regex="abc foo def"
  local readonly replacement="bar"
  local readonly file_contents="abc foo def"

  echo "$file_contents" > "$tmp_file"

  run _file_replace_text "$original_regex" "$replacement" "$tmp_file"
  assert_success

  # shellcheck disable=SC2155
  local readonly actual=$(cat "$tmp_file")
  local readonly expected="$replacement"
  assert_equal "$expected" "$actual"

  rm -f "$tmp_file"
}

@test ".unit.os._file_replace_text non empty file, regex match" {
  # shellcheck disable=SC2155
  local readonly tmp_file=$(mktemp)
  local readonly original_regex=".*foo.*"
  local readonly replacement="bar"
  local readonly file_contents="abc foo def"

  echo "$file_contents" > "$tmp_file"

  run _file_replace_text "$original_regex" "$replacement" "$tmp_file"
  assert_success

  # shellcheck disable=SC2155
  local readonly actual=$(cat "$tmp_file")
  # shellcheck disable=SC2034
  local readonly expected="$replacement"
  assert_equal "$expected" "$actual"

  rm -f "$tmp_file"
}

@test ".unit.os._is_command_found - check for sed" {
    run _is_command_found sed
    assert_success
}

@test ".unit.os._is_command_found - check for InValid_Command" {
    run _is_command_found InValid_Command
    assert_failure
}

@test ".unit.os.prompt - echo to standard err" {
    run prompt  "to_standard_err"
    assert_output "to_standard_err"
}

@test ".unit.os.all_colors - display color" {
    run all_colors
    assert_output --partial  "Colour"
}

@test ".unit.os.lls List with Permission for tdd_run.sh" {
  run lls
  assert_output --partial "-r"
}






