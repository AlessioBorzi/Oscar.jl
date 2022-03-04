###
# stabble intersections in Oscar
# ===============================
###



###
# 1. Definition
# -------------
# M = typeof(min) or typeof(max):
#   min or max convention
###


@doc Markdown.doc"""
    stableIntersection()

Construct a tropical linear space from a degree 1 polynomial ideal

# Examples
"""
function StableIntersection(V1::TropicalVariety, V2::TropicalVariety)
    PC1 = V1.polyhedralComplex
    mults1 = V1.multiplicities
    maximal_pols1 = PC1.pm_complex.MAXIMAL_POLYTOPES
    weights = [mults1[findall(c -> c for c in ind)] for ind in maximal_pols1]
    verts1 = PC1.pm_complex.VERTICES
    cycle1 = Polymake.tropical.Cycle{min}(PROJECTIVE_VERTICES = verts1, WEIGHTS = weights1)

    PC2 = V2.polyhedralComplex
    mults2 = V2.multiplicities
    maximal_pols2 = PC2.pm_complex.MAXIMAL_POLYTOPES
    weights = [mults2[findall(c -> c for c in ind)] for ind in maximal_pols2]
    verts2 = PC2.pm_complex.VERTICES
    cycle2 = Polymake.tropical.Cycle{min}(PROJECTIVE_VERTICES = verts2, WEIGHTS = weights1)

    Polymake.tropical.intersect(cycle1, cycle2)

  return #...
end