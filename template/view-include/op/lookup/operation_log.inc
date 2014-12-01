<select name="operation_type">
[% IF on_empty %]<option value="">-</option>[% END %]
[% SET lookup_operation_type = lookup_const('operation_type') %]
[% FOREACH k IN lookup_operation_type.keys() %]
 <option value="[% k %]">[% lookup_operation_type.${k} %]</option> 
[% END %]
</select>
