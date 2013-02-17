

function notifyParrent( aHeight )
{
	parent.setPopupSize( document.body.clientHeight );
//	if (parent != this)
//	{
//		if ( ! aHeight ) aHeight = $(document).height();
//		if ( aHeight < my_minimum_size ) aHeight = my_minimum_size;
//		parent.onLoadPage( my_id, aHeight );
//	}
}

function showHideTestStep( anElement )
{
	greatgrandfather = anElement.parentNode.parentNode.parentNode;
	rows = greatgrandfather.getElementsByClassName('substeps');
	substeps = rows[0];

	if (anElement.getAttribute('src') == 'plus.gif')
	{
		anElement.setAttribute('src','minus.gif');
		substeps.setAttribute('style','display:block;');
	}
	else
	{
		anElement.setAttribute('src','plus.gif');
		substeps.setAttribute('style','display:none;');
	}
	notifyParrent();
}


