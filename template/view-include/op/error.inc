[% IF error_obj %]
<ul>
[% FOREACH message IN error_obj.errors() %]
<li>[% message %]</li>
[% END %]
[% FOREACH key IN error_obj.custom_invalid %]
<li>Custom Error: [% key %]</li>
[% END %]
</ul>
[% END %]
