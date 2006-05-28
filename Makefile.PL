use inc::Module::Install;

perl_version '5.8.1';

name 'HTML-Simple';
all_from 'lib/HTML/Simple.pm';

requires 'HTML::Entities';

auto_install;
WriteAll;
