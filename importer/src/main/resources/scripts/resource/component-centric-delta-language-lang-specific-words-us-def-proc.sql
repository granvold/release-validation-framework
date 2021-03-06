
/******************************************************************************** 
	component-centric-delta-language-lang-specific-words-us-def-proc

	Assertion:	
	Defines procedure that tests that terms that contain EN-US 
	language-specific words are in the same US language refset.

********************************************************************************/

	drop procedure if exists usTerm_procedure;
	CREATE PROCEDURE usTerm_procedure(runid BIGINT, assertionid varchar(36))  
	begin 
		declare no_more_rows INTEGER DEFAULT 0;
		declare gbTerm VARCHAR(255); 
		declare term_cursor cursor for 
			select term from res_gbterm; 

		declare continue handler for not found set no_more_rows = 1; 

		open term_cursor; 

		validate : 
			loop fetch term_cursor into gbTerm; 

			if no_more_rows = 1
				then close term_cursor; 
				leave validate; 
			end if; 

			insert into qa_result (runid, assertion_id,concept_id,details)
			select 
				runid,
				assertionid,
				a.conceptid,
				concat('DESCRIPTION: id=',a.id, ': Synonym is prefered in US Language refset but refers to a word has en-gb spelling: ',gbTerm) 
			from v_curr_delta_us a 
			where a.term REGEXP concat('[[:<:]]',gbTerm,'[[:>:]]');
		end loop validate; 
	end;
	
	