cimport cython
import cython
from libc.stdio cimport printf
from libcpp.vector cimport vector
from libcpp.utility cimport pair
from libc.stdint cimport *
import ctypes

ctypedef void (*callback_function)(size_t, size_t) noexcept nogil
ctypedef void (*pure_rustc_function)(const char*, const char*, callback_function*) noexcept nogil
ctypedef pair[size_t,size_t] size_t_pair

cdef:
    list _func_cache = []
    vector[size_t_pair] result_vector

cdef pure_rustc_function* get_c_function_ptr():
    cta = ctypes.cdll.LoadLibrary(r"C:\ProgramData\anaconda3\envs\regextest\regexrusttest\target\release\regex_dll.dll")
    _func_cache.append(cta)
    return (<pure_rustc_function*><size_t>ctypes.addressof(cta.for_each_match))

cdef void callback_function_cpp(size_t start, size_t end) noexcept nogil:
    result_vector.emplace_back(size_t_pair(start,end))

cdef:
    callback_function* ptr_callback_function = <callback_function*>callback_function_cpp
    pure_rustc_function* fu = get_c_function_ptr()

def test_converter_bytestring(const unsigned char[:] regex, const unsigned char[:] string):
    cdef:
        const char* r = <const char*>(&(regex[0]))
        const char* s = <const char*>(&(string[0]))
        list[(int64_t,int64_t)] resultados
    with nogil:
        fu[0](r,s,ptr_callback_function)
    resultados=result_vector
    result_vector.clear()
    return resultados

