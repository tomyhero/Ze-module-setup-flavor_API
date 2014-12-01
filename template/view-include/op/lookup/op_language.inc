<select name="op_language">
[% IF on_empty %]<option value="">-</option>[% END %]
[% FOREACH op_language IN support_op_languages %]
<option value="[% op_language %]">[% op_language %]</option>
[% END %]
</select>
