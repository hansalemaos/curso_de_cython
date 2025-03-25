#ifndef subproccython_hpp
#define _CRT_SECURE_NO_WARNINGS
#include <cstdio>
#include <cstring>
#include <string>
#ifdef _WIN32
#define EXEC_CMD(command, mode) _popen(command, mode)
#define CLOSE_CMD(pipe) _pclose(pipe)
#else
#include <unistd.h>
#define EXEC_CMD(command, mode) popen(command, mode)
#define CLOSE_CMD(pipe) pclose(pipe)
#endif

std::string executar_cmd(std::string &cmd)
{
    std::string output;
    FILE *pipe{EXEC_CMD(cmd.c_str(), "r")};
    if (!pipe)
    {
        return "";
    }
    static constexpr size_t buffer_size{128};
    char buffer[buffer_size];
    while (NULL != fgets(buffer, buffer_size, pipe))
    {
        output.append(buffer);
        std::memset(buffer, 0, buffer_size);
    }
    CLOSE_CMD(pipe);
    return output;
}
#endif
