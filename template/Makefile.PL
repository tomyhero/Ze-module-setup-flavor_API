use inc::Module::Install;
name '<+ dist +>';
all_from 'lib/<+ dist +>.pm';

requires (
  "Ze" => 0.04,
  "Aplon" => 0,
  "DBD::mysql" => 0,
  "Devel::KYTProf" => 0,
  "Proc::Guard" => 0,
  "HTTP::Session" => 0,
  "POSIX::AtFork" => 0,
  "File::RotateLogs" => 0,
  "Plack::Middleware::ServerStatus::Lite" => 0,
  "Plack::Middleware::ReverseProxy" => 0,
  "FormValidator::LazyWay" => 0,
  "Data::Page" => 0,
  "Data::Page::Navigation" => 0,
  "URI::QueryParam" => 0,
  "Data::Section::Simple" => 0,
  "DBIx::TransactionManager" => 0,
  "Data::ObjectDriver" => 0,
  "DateTime::Format::MySQL" => 0,
  "Data::GUID" => 0,
  "Data::GUID::URLSafe" => 0,
  "Digest::SHA" => 0,
  "Data::LazyACL" => 0,
  "Locale::Maketext::Lexicon" => 0,
  "Furl" => 0,
);

test_requires(
    'Test::LoadAllModules' => 0,
);

tests_recursive;

build_requires 'Test::More';
auto_include;
WriteAll;
