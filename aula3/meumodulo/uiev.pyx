import cv2
cimport numpy as np
import numpy as np
from libc.stdint cimport *
from cython.parallel cimport prange
cimport openmp
from libcpp.vector cimport vector

ctypedef struct resultados:
    Py_ssize_t x
    Py_ssize_t y
    uint8_t r
    uint8_t g
    uint8_t b

cpdef procurar_cores_cpp(uint8_t[:,:,::1] imagem, uint8_t[:,::1] cores_para_procurar, int cpus=5, int reservar=10000):
    cdef:
        Py_ssize_t c,i,j
        vector[resultados] resultadosvec
        openmp.omp_lock_t locker
    openmp.omp_set_num_threads(cpus)
    openmp.omp_init_lock(&locker)
    resultadosvec.reserve(reservar)
    for c in prange(cores_para_procurar.shape[0], nogil=True):
        for i in range(imagem.shape[0]):
            for j in range(imagem.shape[1]):
                if (
                    (imagem[i, j, 0] == cores_para_procurar[c, 0])
                    and (imagem[i, j, 1] == cores_para_procurar[c, 1])
                    and (imagem[i, j, 2] == cores_para_procurar[c, 2])
                ):
                    openmp.omp_set_lock(&locker)
                    resultadosvec.emplace_back(
                        resultados(
                            j,
                            i,
                            cores_para_procurar[c, 2],
                            cores_para_procurar[c, 1],
                            cores_para_procurar[c, 0],
                        )
                    )
                    openmp.omp_unset_lock(&locker)
    openmp.omp_destroy_lock(&locker)
    return resultadosvec


cpdef procurar_cores(uint8_t[:,:,::1] imagem, uint8_t[:,::1] cores_para_procurar):
    cdef:
        Py_ssize_t c,i,j
        list[dict[str,Py_ssize_t]] resultados = []
    for c in prange(cores_para_procurar.shape[0], nogil=True):
        for i in range(imagem.shape[0]):
            for j in range(imagem.shape[1]):
                if (
                    (imagem[i, j, 0] == cores_para_procurar[c, 0])
                    and (imagem[i, j, 1] == cores_para_procurar[c, 1])
                    and (imagem[i, j, 2] == cores_para_procurar[c, 2])
                ):
                    with gil:
                        resultados.append(
                        {
                            "x": j,
                            "y": i,
                            "r": cores_para_procurar[c, 2],
                            "g": cores_para_procurar[c, 1],
                            "b": cores_para_procurar[c, 0],
                        }
                    )
    return resultados


