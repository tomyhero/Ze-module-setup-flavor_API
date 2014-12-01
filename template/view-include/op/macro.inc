[% MACRO paginate(pager,my_uri) BLOCK -%]
[%- IF pager -%]

    [%- CALL pager.uri(my_uri) -%]
    [%- IF pager.last_page != pager.first_page -%]
				<div class="pager">
					<ul>
					[%- IF pager.previous_page %]<li><a href="[% pager.build_uri(pager.previous_page) %]" class="prev">&laquo;&nbsp;Prev</a></li>[% END -%]
					[%- FOR p IN pager.pages_in_navigation(5) -%]
					[%- IF p == pager.current_page %]<li><span>[% p %]</span></li>[% ELSE %]<li><a href="[% pager.build_uri(p) %]" class="number">[% p %]</a></li>[% END -%]
					[%- END -%]
					[%- IF pager.next_page %]<li><a href="[% pager.build_uri(pager.next_page) %]" class="next">Next&nbsp;&raquo;</a></li>[% END -%]
					</ul>
					<form class="navbar-form pull-left" action="[% pager.uri(my_uri) %]" method="get">
					<input type="text" class="input-mysize" name="p"/> / [% pager.last_page %]
					<button type="submit" class="btn">Go</button>
					</form>
        </div><!-- /pager -->

    [%- END # over 1 page -%]
[% END -%]
[% END -%]
