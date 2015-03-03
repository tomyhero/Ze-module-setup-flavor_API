[%-
  SET MENU = [
    ['top','Top', '/',0],
    ['member','Member', '/member/',constants.OP_ACL_OPERATION],
    ['my','My', '/my/operator/',0],
    ['admin','Admin', '/admin/operator/',constants.OP_ACL_ADMIN],
  ];
-%]
[%-
  SET SUB_MENU = {
    top => [['top','top page','/']],
    my => [
        ['operator','account','/my/operator/'],
        ['operator_edit','edit','/my/operator/edit'],
        ['operator_edit_password','edit password','/my/operator/edit_password'],
    ],
    member => [
      ['list','Member List','/member/'],
    ],
    admin => [
      ['operator_list','Operator List','/admin/operator/'],
      ['operator_add','Add New Operator','/admin/operator/add'],
      ['operation_log_list','Operation Log','/admin/operation_log/'],
    ],
  };
-%]
<div id="menu_container">
<ul id="menu">
[% FOREACH i IN MENU %]
  [% UNLESS i.3 == 0 or operator_obj.has_privilege(i.3) %]
    [% NEXT %]
  [% END %]
  <li>[% IF i.0 == header.menu %]<b>[% i.1 %]</b>[% ELSE %]<a class="menu-[% i.0 %]" href="[% c.uri_for(i.2) %]">[% i.1 %]</a>[% END %]</li>
[% END %]
</ul>

[% SET sub_menus = SUB_MENU.${header.menu} %]
<ul id="sub_menu">
[% FOREACH i IN sub_menus %]
 <li>[% IF i.0 == header.sub_menu %]<b>[% i.1 %]</b>[% ELSE %]<a class="menu-[% i.0 %]" href="[% c.uri_for(i.2) %]">[% i.1 %]</a>[% END %]</li>
[% END %]
</ul>
</div>

