#!/usr/bin/env bash

# 遍历当前目录下的所有py文件，在上一级目录中建立一个同名bash文件，内部逻辑为调用当前py文件
for py_file in *.py; do
    if [[ -f "$py_file" ]]; then
        bash_file="../${py_file%.py}"
        rm -f "$bash_file"
        echo "#!/usr/bin/env bash" > "$bash_file"
        echo "source $(realpath .venv/bin/activate)" >> "$bash_file"
        echo "python3 $(realpath "$py_file") \"\$@\"" >> "$bash_file"
        chmod +x "$bash_file"
    fi
done
