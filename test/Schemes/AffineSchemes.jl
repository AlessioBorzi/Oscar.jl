@testset "affine schemes" begin
  R, (x,y,z) = QQ["x", "y", "z"]
  A3 = Spec(R)
  set_name!(A3, "𝔸³")
  f = x*y-z^2
  I = ideal(R, f)
  X = subscheme(A3, I)
  set_name!(X, "X")
  @test iszero(OO(X)(f))
  U = hypersurface_complement(A3, x)
  set_name!(U, "U")
  UX = intersect(X, U)
  set_name!(UX, "U ∩ X")
  @test X == closure(UX, A3)
  @test is_open_embedding(UX, X)
  @test is_closed_embedding(X, A3)
  UZ = subscheme(UX, y^2)
  Z = subscheme(X, y^2)
  @test closure(UZ, X) == Z
  
  S, (u,v) = QQ["u", "v"]
  A2 = Spec(S)
  set_name!(A2, "𝔸²")
  @test OO(UX)(y//z) == OO(UX)(z//x)
  phi = SpecMor(UX, A2, [y//z, z])
  L = subscheme(A2, u-v)
  phi_L = preimage(phi, L)
  @test OO(phi_L)(y//z) == OO(phi_L)(z)
  psi = restrict(phi, phi_L, L)
  Gamma_psi, p, q = graph(psi)
  @test iszero(pullback(p)(OO(phi_L)(y//z)) - pullback(q)(OO(L)(v)))
  
  mirr = SpecMor(X, X, [y, x, z])
  @test is_isomorphism(mirr)
  @test pullback(compose(inverse(mirr), mirr))(OO(X)(x^2-34*z)) == OO(X)(x^2-34*z+ f^2)
end
