
  <table class="form">
  [% IF mode  == 'add' %]
    <tr>
      <th>Email</th>
       <td><input type="text" name="email" value=""></td>
    </tr>
    <tr>
      <th>Name</th>
       <td><input type="text" name="op_name" value=""></td>
    </tr>
    <tr>
      <th>Password</th>
       <td><input type="text" name="password" value=""></td>
    </tr>
    <tr>
      <th>timezone</th>
       <td>
       [% INCLUDE 'lookup/op_timezone.inc' %]
       </td>
    </tr>
    <tr>
      <th>language</th>
       <td>
       [% INCLUDE 'lookup/op_language.inc' %]
        </td>
    </tr>
    [% ELSE %]
    <tr>
      <th>Email</th>
       <td>[% obj.email %]</td>
    </tr>
    <tr>
      <th>Name</th>
       <td>[% obj.op_name %]</td>
    </tr>
    <tr>
      <th>timezone</th>
       <td>[% obj.op_timezone %]</td>
    </tr>
    <tr>
      <th>language</th>
       <td>[% obj.op_language %]</td>
    </tr>
    <tr>
      <th>active</th>
       <td>
        [% INCLUDE 'lookup/on_active.inc' %]
       </td>
    </tr>
    [% END %]
    <tr>
      <th>Access Control</th>
       <td>
          [% FOREACH k IN access_keys.keys() %]
            <input type="checkbox" name="op_access_key" value="[% access_keys.${k} %]" />[% access_keys.${k} %]
          [% END %]
       </td>
    </tr>
    <tr>
      <th>Operation Memo</th>
      <td>
        <textarea name="operation_memo"></textarea>
      </td>
    </tr>
    <tr>
      <th align="right" colspan="2"><input type="submit" value="[% IF mode == 'add' %]Add[% ELSE %]Edit[% END %]" /></th>
    </tr>
  </table>
