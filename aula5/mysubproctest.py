from mysubproc import execute_subprocess

resultado = execute_subprocess(["ls", "dir", "ls -l"])
print(resultado)
for key, item in resultado.items():
    print(key)
    print(item)
    print("--------------------------------")
