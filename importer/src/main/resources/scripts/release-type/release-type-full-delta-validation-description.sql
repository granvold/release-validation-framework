
/*  
	The current full description file consists of the previously published full file and the changes for the current release
*/
	insert into qa_result (runid, assertionuuid, concept_id, details)
	select 
	<RUNID>,
	'<ASSERTIONUUID>',
	a.conceptid,
	concat('Description: id=',a.id, ' is in current full file, but not in prior full or current delta file.') 	
	from curr_description_f a
	left join curr_description_d b
		on a.id = b.id
		and a.effectivetime = b.effectivetime
		and a.active = b.active
		and a.moduleid = b.moduleid
		and a.conceptid = b.conceptid
		and a.languagecode = b.languagecode
		and a.typeid = b.typeid
		and a.term = b.term
		and a.casesignificanceid = b.casesignificanceid
	left join prev_description_f c
		on a.id = c.id
		and a.effectivetime = c.effectivetime
		and a.active = c.active
		and a.moduleid = c.moduleid
		and a.conceptid = c.conceptid
		and a.languagecode = c.languagecode
		and a.typeid = c.typeid
		and a.term = c.term
		and a.casesignificanceid = c.casesignificanceid
	where ( b.id is null
	or b.effectivetime is null
	or b.active is null
	or b.moduleid is null
	or b.conceptid is null
	or b.languagecode is null
	or b.typeid is null
	or b.term is null
	or b.casesignificanceid is null)
	and ( c.id is null
	or c.effectivetime is null
	or c.active is null
	or c.moduleid is null
	or c.conceptid is null
	or c.languagecode is null
	or c.typeid is null
	or c.term is null
	or c.casesignificanceid is null );
commit;
