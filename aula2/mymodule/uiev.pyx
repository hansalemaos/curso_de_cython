import numpy as np
cimport numpy as np
from libc.stdint cimport *
from libcpp.vector cimport vector 
from time import perf_counter

ctypedef struct resultstruct:
    int64_t index
    int64_t val1
    int64_t val2
    int64_t val3


def find_nearest_cython(l):
    results = []
    for i in range(1, len(l) - 1, 1):
        if l[i] > 900000 and l[i] > l[i - 1] and l[i] < l[i + 1]:
            results.append(
                {"index": i, "val1": l[i - 1], "val2": l[i], "val3": l[i + 1]},
            )
    return results

def find_nearest_cython_anotacao(list l):
    cdef:
        list results = []
        Py_ssize_t i
    for i in range(1, len(l) - 1, 1):
        if l[i] > 900000 and l[i] > l[i - 1] and l[i] < l[i + 1]:
            results.append(
                {"index": i, "val1": l[i - 1], "val2": l[i], "val3": l[i + 1]},
            )
    return results

def find_nearest_cython_anotacao_np(int64_t[:] l):
    cdef:
        list results = []
        Py_ssize_t i
    for i in range(1, len(l) - 1, 1):
        if l[i] > 900000 and l[i] > l[i - 1] and l[i] < l[i + 1]:
            results.append(
                {"index": i, "val1": l[i - 1], "val2": l[i], "val3": l[i + 1]},
            )
    return results

def find_nearest_cython_anotacao_vec(int64_t[:] l):
    cdef:
        vector[resultstruct] results
        Py_ssize_t i
    results.reserve(len(l)//10)
    for i in range(1, len(l) - 1, 1):
        if l[i] > 900000 and l[i] > l[i - 1] and l[i] < l[i + 1]:
            results.emplace_back(
                resultstruct(i,  l[i - 1],  l[i],  l[i + 1]),
            )
    return results

def find_nearest_cython_anotacao_vec2(int64_t[:] l):
    cdef:
        vector[resultstruct] results
        Py_ssize_t i
    start=perf_counter()
    results.reserve(len(l)//20)
    for i in range(1, len(l) - 1, 1):
        if l[i] > 900000 and l[i] > l[i - 1] and l[i] < l[i + 1]:
            results.emplace_back(
                resultstruct(i,  l[i - 1],  l[i],  l[i + 1]),
            )
    print(perf_counter()-start)
    return results