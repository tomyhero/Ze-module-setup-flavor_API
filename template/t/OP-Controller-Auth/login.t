use Test::More;
use t::Util;
use <+ dist +>X::Util;
use <+ dist +>::Model::Operator;

cleanup_database;

test_op(sub {
        my $cb  = shift;
        {
          my $res = $cb->(GET "/auth/login",{});
          is(200,$res->code)
        }

        {

          my $operator_obj = create_operator_obj();
          my $res = $cb->(POST "/auth/login",{ email => $operator_obj->email ,password => 'secret' });
          ok( $res->headers->header('Set-Cookie') );
          is(302,$res->code)
        }

});


done_testing();
