base='bean'
target='converter.dart'
rm $target
find $base -regex "[A-Za-z_/]*.dart" -print0 | while read -d $'\0' file
do
    echo "import '$file';" >> $target
done

printf "\nclass Converter {\n" >> $target
printf "\tstatic getFromJson<T>(Type type, Map<String,dynamic> json) {\n" >> $target
printf "\t\tswitch (type) {\n" >> $target

find $base -name "*.dart" -print0 | while read -d $'\0' file
do
  name=$(awk "/class[^A-Za-z]/" "$file" | awk '{print $2}')
  if [ -n "$name" ]; then
    printf "\t\t\tcase $name:\n" >> $target
    printf "\t\t\t\treturn $name.fromJson(json);\n" >> $target
  fi
done

printf "\t\t}\n" >> $target
printf "\t\tprint('Type error! You may forgot to generate converter_gen.sh');\n" >> $target
printf "\t\treturn null;\n" >> $target
printf "\t}\n" >> $target
printf "}\n" >> $target