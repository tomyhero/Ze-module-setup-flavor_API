use Module::Setup::Test::Flavor;

run_flavor_test {
    default_dialog;
    name 'MyApp';
    flavor '+DevelTestFlavor';
    file 'testfile.txt' => qr/hel+o/, qr/API/;
    dirs qw( testdir );
};
