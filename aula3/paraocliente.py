from meumodulo import *
from time import perf_counter


imagem = cv2.imread(r"C:\Users\hansc\Downloads\pexels-alex-andrews-271121-2295744.jpg")
cores_para_procurar = np.array(
    [
        (66, 71, 69),
        (62, 67, 65),
        (144, 155, 153),
        (52, 57, 55),
        (127, 138, 136),
        (53, 58, 56),
        (51, 56, 54),
        (32, 27, 18),
        (24, 17, 8),
    ],
    dtype=np.uint8,
)
start_time = perf_counter()
resultado = procurar_cores(imagem, cores_para_procurar)
print(perf_counter() - start_time)

print(resultado)
procurar_cores_cpp(imagem, cores_para_procurar, cpus=5, reservar=100000)
