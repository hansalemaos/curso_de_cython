from libcpp.string cimport string
from cython.parallel cimport prange
from libcpp.unordered_map cimport unordered_map
from libcpp.vector cimport vector

cdef extern from "subproccython.hpp" nogil:
    string executar_cmd(string &cmd)

cpdef execute_subprocess(list[str] cmds):
    cdef:
        vector[string] unique_cmds=list(set(cmds))
        unordered_map[string,string] resultdict = {}
        Py_ssize_t i

    for i in range(unique_cmds.size()):
        resultdict[unique_cmds[i]]

    for i in prange(<Py_ssize_t>unique_cmds.size(),nogil=True):
        resultdict[unique_cmds[i]]=executar_cmd(unique_cmds[i])

    return resultdict
