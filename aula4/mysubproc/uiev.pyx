from libcpp.string cimport string


cdef extern from "subproccython.hpp" nogil:
    string executar_cmd(string &cmd)

cpdef execute_subprocess(str cmd):
    cdef:
        string cppstring = cmd.encode()
        string resultstring
    resultstring = executar_cmd(cppstring)
    return resultstring
