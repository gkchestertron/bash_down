# build the section_no array from the current depth and existing array
get_section_no(){
  length=${#section_no[@]}

  if [ "$length" -lt "$depth" ]
  then
    # add non-existent section segments
    while [ "$length" -lt "$depth" ]
    do
      section_no+=(0)
      length=${#section_no[@]}
    done
  elif [ "$length" -gt "$depth" ]
  then
    # slice off unnecessary segments
    section_no=("${section_no[@]:0:$depth}")
  fi

  # increment last element
  ((section_no[${#section_no[@]} - 1]++))
}

# join array
join_by (){ 
  local IFS="$1"; shift; echo "$*"; 
}

# local parser
local_parser(){
  script="$(echo $line | sed 's/^[ ]*#!//' | sed 's/ .*$//')"
  cmd=$(echo $line | sed 's/^[ ]*#![^ ]* *//' | sed 's/ *$//')
  if [ -f "$ouput_dir/tests/$cmd" ]
  then
    output=`cat "$output_dir/tests/$cmd"`
    cat <<< "$output" >> "$output_dir/build/tests/$script"
  elif [ ! -z "$cmd" ]
  then
    output=`"./__bd__/parsers/$script" "$last_line" "$heading" "$cmd"`
    cat <<< "$output" >> "$output_dir/build/tests/$script"
  else
    cur_script="$output_dir/build/tests/$script"
    output=`"./__bd__/parsers/$script" "$last_line" "$heading"`
    cat <<< "$output" >> "$output_dir/build/tests/$script"
  fi
  ((test_no++))
}

# inline script 
inline_script(){
  # default to using bash
  if [ "$line" = '#!' ]
  then
    hash_bang='#!/bin/bash'
  else
    hash_bang="$line"
  fi

  cur_script="$output_dir/build/scripts/$script_no"_"$heading_path"
  echo "$hash_bang" > "$cur_script"
}

# close inline script
inline_script_close(){
  if [ -z "$commented_script" ]
  then
    chmod +x $cur_script
  fi
  commented_script=""
  cur_script=""
  ((script_no++))
}

# heading - generate section number and write to markdown
heading() {
  hashes="$(echo $line | sed s/[^#].*$//)"
  heading="$(echo $line | sed s/^[#]*//)"
  heading_path="$(echo $heading | sed -E 's/[^_a-zA-Z0-9]+/-/g')"
  depth=${#hashes}
  get_section_no
  section=$(join_by . "${section_no[@]}")
  echo "$hashes $section $heading" >> $output_dir/build/spec.md
  echo "$section $heading" >> $output_dir/build/spec.txt
}
