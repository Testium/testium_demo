

function showHideTestGroup()
{
	if (document.getElementById('subTestGroups').style.display == 'none')
	{
		hide('testGroupHeaderInfo');
		show('testGroupHeaderFilter');
		show('prepare');
		show('subTestGroups');
		show('testcases');
		show('restore');
		show('testLogs');
		show('totalsBeneath'); 
		document.getElementById('testgroupheader_plusmin').setAttribute('src','minus.gif');
	}
	else
	{
		show('testGroupHeaderInfo');
		hide('testGroupHeaderFilter');
		hide('prepare');
		hide('subTestGroups');
		hide('testcases');
		hide('restore');
		hide('testLogs');
		hide('totalsBeneath'); 
		document.getElementById('testgroupheader_plusmin').setAttribute('src','plus.gif');
	}
}

function show(id)
{
  document.getElementById(id).style.display = 'block';
}

function hide(id)
{
  document.getElementById(id).style.display = 'none';
}

function showPopup(tcId, tcVerdict, tcLink)
{
  document.getElementById('popup_id').innerHTML=tcId;
  document.getElementById('popup_verdict').innerHTML=tcVerdict;
  document.getElementById('popup').style.display = 'block';
  frames['popup_link'].location.href=tcLink;
}

function setPopupSize(aHeight)
{
//	<!-- Don't know why, but we need about 8px more -->
	if ( aHeight )
		document.getElementById('ifr_popup').setAttribute('height',aHeight + 8 );
}

function showHideRows(testgroupid, severity)
{
  var table = document.getElementById(testgroupid + "table"); 
  var rows = table.getElementsByTagName("tr");

  for(i = 0; (rows.length - i) != 0; i++)
  {
    var hasInnerText = (rows[i].cells[1].innerText != undefined) ? true : false;

    if (!hasInnerText)
    {
      sev = rows[i].cells[1].textContent;
    }
    else
    {
      sev = rows[i].cells[1].innerText;
    }
				
    if (severity == "all")
    {
      rows[i].style.display = '';
    }
    else
    {
      if (sev == severity)
      {
        rows[i].style.display = '';
      }
      else
      {
        rows[i].style.display = 'none';
      }
    }
  }
}

function onLoadPage(id, size)
{
//	document.getElementById("debug_label").innerHTML = "Size"; 
//	document.getElementById("debug_value").innerHTML = size; 

	if ( ! size ) size = 0;

	if ( id )
	{
		element = document.getElementById('ifr_' + id);
		if ( element )
			element.setAttribute('height',size);
	}
}

