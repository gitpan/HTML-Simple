package HTML::Simple;

use strict;
use warnings;
use base 'Exporter';
use HTML::Entities 'encode_entities';

our $VERSION = '1.0';

sub TAG (@) {
    my ( $attributes, @more ) = @_;

    my $sub = ( caller(1) )[3];
    $sub =~ /.*::(.*)$/;
    my $tag = lc $1;

    my $html = "<$tag";
    $attributes ||= {};

    my $content;
    for my $key ( keys %$attributes ) {

        my $value = $attributes->{$key};

        if ( $key eq '_' ) {
            $content = $value;
            next;
        }

        $html .= qq/ $key="$value"/;
    }

    if ( !$content ) { $html .= '/>' }
    elsif ( ref $content eq 'ARRAY' ) {
        $html .= '>';
        $html .= $_ for @$content;
        $html .= "</$tag>";
    }
    else { $html .= '>' . encode_entities($content) . "</$tag>" }

    return join '', $html, @more;
}

our @EXPORT_OK = qw/
  A
  ABBR
  ACRONYM
  ADDRESS
  AREA
  B
  BASE
  BDO
  BIG
  BLOCKQUOTE
  BODY
  BR
  BUTTON
  CAPTION
  CITE
  CODE
  COL
  COLGROUP
  DD
  DEL
  DIV
  DFN
  DL
  DT
  EM
  FIELDSET
  FORM
  FRAME
  FRAMESET
  H1
  H2
  H3
  H4
  H5
  H6
  HEAD
  HR
  HTML
  I
  IFRAME
  IMG
  INPUT
  INS
  KBD
  LABEL
  LEGEND
  LI
  LINK
  MAP
  META
  NOFRAMES
  NOSCRIPT
  OBJECT
  OL
  OPTGROUP
  OPTION
  P
  PARAM
  PRE
  Q
  SAMP
  SCRIPT
  SELECT
  SMALL
  SPAN
  STRONG
  STYLE
  SUB
  SUP
  TABLE
  TAG
  TBODY
  TD
  TEXTAREA
  TFOOT
  TH
  THEAD
  TITLE
  TR
  TT
  UL
  VAR
  /;
our %EXPORT_TAGS = ( all => \@EXPORT_OK );

sub A (@)          { TAG @_ }
sub ABBR (@)       { TAG @_ }
sub ACRONYM (@)    { TAG @_ }
sub ADDRESS (@)    { TAG @_ }
sub AREA (@)       { TAG @_ }
sub B (@)          { TAG @_ }
sub BASE (@)       { TAG @_ }
sub BDO (@)        { TAG @_ }
sub BIG (@)        { TAG @_ }
sub BLOCKQUOTE (@) { TAG @_ }
sub BODY (@)       { TAG @_ }
sub BR (@)         { TAG @_ }
sub BUTTON (@)     { TAG @_ }
sub CAPTION (@)    { TAG @_ }
sub CITE (@)       { TAG @_ }
sub CODE (@)       { TAG @_ }
sub COL (@)        { TAG @_ }
sub COLGROUP (@)   { TAG @_ }
sub DD (@)         { TAG @_ }
sub DEL (@)        { TAG @_ }
sub DIV (@)        { TAG @_ }
sub DFN (@)        { TAG @_ }
sub DL (@)         { TAG @_ }
sub DT (@)         { TAG @_ }
sub EM (@)         { TAG @_ }
sub FIELDSET (@)   { TAG @_ }
sub FORM (@)       { TAG @_ }
sub FRAME (@)      { TAG @_ }
sub FRAMESET (@)   { TAG @_ }
sub H1 (@)         { TAG @_ }
sub H2 (@)         { TAG @_ }
sub H3 (@)         { TAG @_ }
sub H4 (@)         { TAG @_ }
sub H5 (@)         { TAG @_ }
sub H6 (@)         { TAG @_ }
sub HEAD (@)       { TAG @_ }
sub HR (@)         { TAG @_ }
sub HTML (@)       { TAG @_ }
sub I (@)          { TAG @_ }
sub IFRAME (@)     { TAG @_ }
sub IMG (@)        { TAG @_ }
sub INPUT (@)      { TAG @_ }
sub INS (@)        { TAG @_ }
sub KBD (@)        { TAG @_ }
sub LABEL (@)      { TAG @_ }
sub LEGEND (@)     { TAG @_ }
sub LI (@)         { TAG @_ }
sub LINK (@)       { TAG @_ }
sub MAP (@)        { TAG @_ }
sub META (@)       { TAG @_ }
sub NOFRAMES (@)   { TAG @_ }
sub NOSCRIPT (@)   { TAG @_ }
sub OBJECT (@)     { TAG @_ }
sub OL (@)         { TAG @_ }
sub OPTGROUP (@)   { TAG @_ }
sub OPTION (@)     { TAG @_ }
sub P (@)          { TAG @_ }
sub PARAM (@)      { TAG @_ }
sub PRE (@)        { TAG @_ }
sub Q (@)          { TAG @_ }
sub SAMP (@)       { TAG @_ }
sub SCRIPT (@)     { TAG @_ }
sub SELECT (@)     { TAG @_ }
sub SMALL (@)      { TAG @_ }
sub SPAN (@)       { TAG @_ }
sub STRONG (@)     { TAG @_ }
sub STYLE (@)      { TAG @_ }
sub SUB (@)        { TAG @_ }
sub SUP (@)        { TAG @_ }
sub TABLE (@)      { TAG @_ }
sub TBODY (@)      { TAG @_ }
sub TD (@)         { TAG @_ }
sub TEXTAREA (@)   { TAG @_ }
sub TFOOT (@)      { TAG @_ }
sub TH (@)         { TAG @_ }
sub THEAD (@)      { TAG @_ }
sub TITLE (@)      { TAG @_ }
sub TR (@)         { TAG @_ }
sub TT (@)         { TAG @_ }
sub UL (@)         { TAG @_ }
sub VAR (@)        { TAG @_ }

1;
__END__

=head1 NAME

HTML::Simple - For When Template Systems Are Too Huge And Heredocs Too Messy

=head1 SYNOPSIS

    use HTML::Simple ':all';

    # A simple hello world
    print HTML { 
        _ => [
            HEAD { _ => TITLE { _ => 'Hello World!' } },
            BODY { _ => 'Hello World!' } 
        ]   
    };

    # A simple anchor nested in a div
    print DIV {
        _ => [
            A {
                href => 'http://127.0.0.1',
                _    => '<< Home Sweet Home!'
            }
        ]
    };

=head1 DESCRIPTION

A very simple micro language to generate HTML.

This is not a real template system like L<Template> or L<HTML::Mason>,
it's just a simple (and fun) way to avoid those messy heredocs. ;)

=head1 FUNCTIONS

All functions work the same, they expect a hashref as first argument
which contains attributes for the tag to generate.

The special attribute _ contains the content for the tag.
The content may be a single string (in this case entities
are auto encoded) or a arrayref containing strings that
shouldn't be encoded.

    <TAG> { attribute => 'value' }
    DIV { id => 'foo', _ => 'lalala' }
    DIV { id => 'link' _ => [ '<b>Don't encode me!</b>' ] }
    DIV { _ => [ A { href => 'http://127.0.0.1', _ => 'Home!' } ] }

=head2 A

=head2 ABBR

=head2 ACRONYM

=head2 ADDRESS

=head2 AREA

=head2 B

=head2 BASE

=head2 BDO

=head2 BIG

=head2 BLOCKQUOTE

=head2 BODY

=head2 BR

=head2 BUTTON

=head2 CAPTION

=head2 CITE

=head2 CODE

=head2 COL

=head2 COLGROUP

=head2 DD

=head2 DEL

=head2 DIV

=head2 DFN

=head2 DL

=head2 DT

=head2 EM

=head2 FIELDSET

=head2 FORM

=head2 FRAME

=head2 FRAMESET

=head2 H1

=head2 H2

=head2 H3

=head2 H4

=head2 H5

=head2 H6

=head2 HEAD

=head2 HR

=head2 HTML

=head2 I

=head2 IFRAME

=head2 IMG

=head2 INPUT

=head2 INS

=head2 KBD

=head2 LABEL

=head2 LEGEND

=head2 LI

=head2 LINK

=head2 MAP

=head2 META

=head2 NOFRAMES

=head2 NOSCRIPT

=head2 OBJECT

=head2 OL

=head2 OPTGROUP

=head2 OPTION

=head2 P

=head2 PARAM

=head2 PRE

=head2 Q

=head2 SAMP

=head2 SCRIPT

=head2 SELECT

=head2 SMALL

=head2 SPAN

=head2 STRONG

=head2 STYLE

=head2 SUB

=head2 SUP

=head2 TABLE

=head2 TAG

=head2 TBODY

=head2 TD

=head2 TEXTAREA

=head2 TFOOT

=head2 TH

=head2 THEAD

=head2 TITLE

=head2 TR

=head2 TT

=head2 UL

=head2 VAR

=head1 AUTHOR

Sebastian Riedel, C<sri@oook.de>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
