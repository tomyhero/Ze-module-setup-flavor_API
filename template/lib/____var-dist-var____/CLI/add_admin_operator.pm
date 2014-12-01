package <+ dist +>::CLI::add_admin_operator;
use strict;
use Ze::Class;
extends '<+ dist +>::CLI::Base';
use <+ dist +>::Model::Operator;

sub run {
    my ($self, $opt, $args) = @_;
    print "your email: ";
    my $email= <STDIN>;
    chomp($email);

    print "your name:";
    my $op_name = <STDIN>;
    chomp($op_name);

    print "password: ";
    system("stty -echo");
    my $password = <STDIN>;
    chomp($password);
    system("stty echo");

    print "\nconfirm password: ";
    system("stty -echo");
    my $re_password = <STDIN>;
    chomp($re_password);
    system("stty echo");
    unless ($password eq $re_password) {
        die "\npassword is invalid.";
    }
    print "\n";

    <+ dist +>::Model::Operator->new->create_admin_operator({
        email => $email,
        password => $password,
        op_name => $op_name,
    });
    print "registered.\n";
}



EOC;
