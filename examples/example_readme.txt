x, y

begin proc foobar(val z, u, res v) is
  if z < 3 then v := 1
  else (
    call foobar(z - 2, 0, u) ;
    call foobar(z - 1, 0, v) ;
    v := v + u
  ) end ;
  call foobar(x, 0, y)
end

begin proc main(res rv) is
  x := 10 ;
  call foobar(3, y, rv)
end
