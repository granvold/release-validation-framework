
/******************************************************************************** 
	component-centric-snapshot-snomed-rt-active

	Assertion:
	SNOMED RT identifier simple map refset members are always active.

********************************************************************************/
	
	
	insert into qa_result (runid, assertionuuid, concept_id, details)
	select 
		<RUNID>,
		'<ASSERTIONUUID>',
		a.referencedcomponentid,
		concat('SimpleMapRefset: id=',a.id, ' is not an active SNOMED RT member.') 
	from curr_simplemaprefset_s a
	where a.refsetid = '900000000000498005'
	and a.active != '1';