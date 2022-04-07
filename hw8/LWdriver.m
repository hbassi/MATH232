clear all;

m = [ 50 100 200 400 800 1600 ];
N = length( m );

mesh_widths     = zeros(1,N);
computed_errors = zeros(1,N);

for j = 1 : N

  [ h, k, error ] = advection_LW_pbc( m(j) );

  mesh_widths(j)     = h;
  computed_errors(j) = error;

end;

error_table( mesh_widths, computed_errors );
error_loglog( mesh_widths, computed_errors );
