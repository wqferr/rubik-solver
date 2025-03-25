init = =>
    Cube.asyncScramble((alg) ->
        puzzle = TTk.AlgorithmPuzzle(3)
            .alg(alg)

        puzzle("#puzzle")
    )

Cube.asyncInit("/cubejs/lib/worker.js", init)
