from mymodule import (
    find_nearest_cython,
    find_nearest_cython_anotacao,
    find_nearest_cython_anotacao_np,
    find_nearest_cython_anotacao_vec,
    find_nearest_cython_anotacao_vec2,
)
import numpy as np

a = np.random.randint(0, 1000000, 100000000, dtype=np.int64)
l = a.tolist()


def find_nearest(l):
    results = []
    for i in range(1, len(l) - 1, 1):
        if l[i] > 900000 and l[i] > l[i - 1] and l[i] < l[i + 1]:
            results.append(
                {"index": i, "val1": l[i - 1], "val2": l[i], "val3": l[i + 1]},
            )
    return results


# result = find_nearest(l)
# result_cython = find_nearest_cython(l)
# result_cython = find_nearest_cython_anotacao(l)
result_cython = find_nearest_cython_anotacao_np(a)
result_cython = find_nearest_cython_anotacao_vec(a)
result_cython = find_nearest_cython_anotacao_vec2(a)

# print(result)
