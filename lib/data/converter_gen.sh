#!/usr/bin/env bash

base='bean'
target='converter.dart'
rm $target
find $base -regex "[A-Za-z_/]*.dart" -print0 | while read -r -d $'\0' file
do
  echo "import '$file';" >> $target
done

{
  printf "\nclass Converter {\n"
  printf "\tstatic getFromJson<T>(Type type, Map<String,dynamic> json) {\n"
  printf "\t\tswitch (type) {\n"
} >> $target

find $base -name "*.dart" -print0 | while read -r -d $'\0' file
do
  name=$(awk "/class[^A-Za-z]/" "$file" | awk '{print $2}')
  if [ -n "$name" ]; then
    {
      printf "\t\t\tcase %s:\n" "$name"
      printf "\t\t\t\treturn %s.fromJson(json);\n" "$name"
    } >> $target
  fi
done

{

} >> $target

{
  printf "\t\t}\n"
  printf "\t\tprint('Type error! You probably forgot to run converter_gen.sh');\n"
  printf "\t\treturn null;\n"
  printf "\t}\n"
  printf "}\n"
} >> $target
