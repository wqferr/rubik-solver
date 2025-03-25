cubeJsToTtkFc = (cubeJsState) ->
    colors = cubeJsState.asString()
        .replace(/U/g, "y")
        .replace(/F/g, "b")
        .replace(/R/g, "r")
        .replace(/L/g, "o")
        .replace(/B/g, "g")
        .replace(/D/g, "w")

    face = (faceIdx) ->
        raw = colors.substring(faceIdx * 9, (faceIdx+1) * 9)
        reordered = raw.substring(6, 9) + raw.substring(3, 6) + raw.substring(0, 3)
        return reordered

    # DRFULB
    down = face 0
    right = face 1
    front = face 2
    up = face 3
    left = face 4
    back = face 5

    # Order from cubejs's documentation
    patched_colors = up + right + front + down + left + back
    return patched_colors


init = =>
    Cube.asyncScramble((alg) ->
        view_scrambled = TTk.InteractivePuzzle(3)
            .alg(alg)

        view_scrambled("#scrambled")

        scrambled = new Cube
        scrambled.move(alg)

        view_solved = TTk.AlgorithmPuzzle(3)
            .fc(cubeJsToTtkFc scrambled)
            .alg(Cube.inverse(alg))
        view_solved("#solved")
    )

Cube.asyncInit("/cubejs/lib/worker.js", init)
