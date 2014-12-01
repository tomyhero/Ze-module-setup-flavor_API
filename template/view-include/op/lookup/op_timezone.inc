<select name="op_timezone">
[% IF on_empty %]<option value="">-</option>[% END %]
[% FOREACH op_timezone IN support_op_timezones %]
<option value="[% op_timezone %]">[% op_timezone %]</option>
[% END %]
</select>
