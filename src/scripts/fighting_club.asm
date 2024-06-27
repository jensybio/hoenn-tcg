FightingClubAfterDuel:
	ld hl, .after_duel_table
	call FindEndOfDuelScript
	ret

.after_duel_table
	db NPC_CHRIS
	db NPC_CHRIS
	dw Script_BeatChrisInFightingClub
	dw Script_LostToChrisInFightingClub

	db NPC_MICHAEL
	db NPC_MICHAEL
	dw Script_BeatMichaelInFightingClub
	dw Script_LostToMichaelInFightingClub

	db NPC_JESSICA
	db NPC_JESSICA
	dw Script_BeatJessicaInFightingClub
	dw Script_LostToJessicaInFightingClub

	db NPC_MITCH
	db NPC_MITCH
	dw Script_BeatMitch
	dw Script_LostToMitch
	db $00

Script_Mitch:
	start_script
	try_give_pc_pack $02
	jump_if_event_true EVENT_BEAT_MITCH, Script_Mitch_AlreadyHaveMedal
	fight_club_pupil_jump .first_interaction, .three_pupils_remaining, \
		.two_pupils_remaining, .one_pupil_remaining, .all_pupils_defeated
.first_interaction
	print_npc_text MitchFirstInteractionText
	set_event EVENT_PUPIL_MICHAEL_STATE, PUPIL_ACTIVE
	set_event EVENT_PUPIL_CHRIS_STATE, PUPIL_ACTIVE
	set_event EVENT_PUPIL_JESSICA_STATE, PUPIL_ACTIVE
	quit_script_fully

.three_pupils_remaining
	print_text_quit_fully Mitch3PupilsRemainingText

.two_pupils_remaining
	print_text_quit_fully Mitch2PupilsRemainingText

.one_pupil_remaining
	print_text_quit_fully Mitch1PupilRemainingText

.all_pupils_defeated
	print_npc_text MitchWouldLikeToDuelInitialText
	ask_question_jump MitchWouldYouLikeToDuelText, .start_duel
	print_npc_text MitchDeclinedInitialText
	quit_script_fully

.start_duel
	print_npc_text MitchDuelStartInitialText
	start_duel PRIZES_6, FIRST_STRIKE_DECK_ID, MUSIC_DUEL_THEME_2
	quit_script_fully

Script_BeatMitch:
	start_script
	jump_if_event_true EVENT_BEAT_MITCH, Script_Mitch_GiveBoosters
	print_npc_text MitchPlayerWonInitial1Text
	max_out_event_value EVENT_BEAT_MITCH
	try_give_medal_pc_packs
	show_medal_received_screen EVENT_BEAT_MITCH
	record_master_win $01
	print_npc_text MitchPlayerWonInitial2Text
	give_booster_packs BOOSTER_LABORATORY_NEUTRAL, BOOSTER_LABORATORY_NEUTRAL, NO_BOOSTER
	print_npc_text MitchPlayerWonInitial3Text
	quit_script_fully

Script_LostToMitch:
	start_script
	jump_if_event_true EVENT_BEAT_MITCH, Script_Mitch_PrintTrainHarderText
	print_text_quit_fully MitchPlayerLostInitialText

Script_Mitch_AlreadyHaveMedal:
	print_npc_text MitchWouldLikeToDuelRepeatText
	ask_question_jump MitchWouldYouLikeToDuelText, .start_duel
	print_npc_text MitchDeclinedDuelRepeatText
	quit_script_fully

.start_duel
	print_npc_text MitchDuelStartRepeatText
	start_duel PRIZES_6, FIRST_STRIKE_DECK_ID, MUSIC_DUEL_THEME_2
	quit_script_fully

Script_Mitch_GiveBoosters:
	print_npc_text MitchPlayerWonRepeat1Text
	give_booster_packs BOOSTER_LABORATORY_NEUTRAL, BOOSTER_LABORATORY_NEUTRAL, NO_BOOSTER
	print_npc_text MitchPlayerWonRepeat2Text
	quit_script_fully

Script_Mitch_PrintTrainHarderText:
	print_text_quit_fully MitchPlayerLostRepeatText

Preload_ChrisInFightingClub:
	get_event_value EVENT_PUPIL_CHRIS_STATE
	cp PUPIL_DEFEATED
	ccf
	ret

Script_de4b:
	test_if_event_equal EVENT_PUPIL_CHRIS_STATE, PUPIL_DEFEATED
	print_variable_npc_text ChrisFightingClubWantsToDuelInitialText, ChrisFightingClubWantsToDuelRepeatText
	set_event EVENT_PUPIL_CHRIS_STATE, PUPIL_REVISITED
	ask_question_jump ChrisWouldYouLikeToDuelText, .ows_de61
	print_npc_text ChrisFightingClubDeclinedDuelText
	quit_script_fully

.ows_de61
	print_npc_text ChrisFightingClubDuelStartText
	start_duel PRIZES_4, MUSCLES_FOR_BRAINS_DECK_ID, MUSIC_DUEL_THEME_1
	quit_script_fully

Script_BeatChrisInFightingClub:
	start_script
	print_npc_text ChrisFightingClubPlayerWon1Text
	give_booster_packs BOOSTER_EVOLUTION_FIGHTING, BOOSTER_EVOLUTION_FIGHTING, NO_BOOSTER
	print_npc_text ChrisFightingClubPlayerWon2Text
	quit_script_fully

Script_LostToChrisInFightingClub:
	start_script
	print_text_quit_fully ChrisFightingClubPlayerLostText

Preload_MichaelInFightingClub:
	get_event_value EVENT_PUPIL_MICHAEL_STATE
	cp PUPIL_DEFEATED
	ccf
	ret

Script_MichaelRematch:
	print_npc_text MichaelFightingClubWantsToDuelText
	ask_question_jump MichaelWouldYouLikeToDuelText, .ows_de8d
	print_npc_text MichaelFightingClubDeclinedDuelText
	quit_script_fully

.ows_de8d
	print_npc_text MichaelFightingClubDuelStartText
	start_duel PRIZES_4, HEATED_BATTLE_DECK_ID, MUSIC_DUEL_THEME_1
	quit_script_fully

Script_BeatMichaelInFightingClub:
	start_script
	print_npc_text MichaelFightingClubPlayerWon1Text
	give_booster_packs BOOSTER_COLOSSEUM_FIGHTING, BOOSTER_COLOSSEUM_FIGHTING, NO_BOOSTER
	print_npc_text MichaelFightingClubPlayerWon2Text
	quit_script_fully

Script_LostToMichaelInFightingClub:
	start_script
	print_text_quit_fully MichaelFightingClubPlayerLostText

Preload_JessicaInFightingClub:
	get_event_value EVENT_PUPIL_JESSICA_STATE
	cp PUPIL_DEFEATED
	ccf
	ret

Script_dead:
	print_npc_text JessicaFightingClubWantsToDuelText
	ask_question_jump JessicaWouldYouLikeToDuelText, .ows_deb9
	print_npc_text JessicaFightingClubDeclinedDuelText
	quit_script_fully

.ows_deb9
	print_npc_text JessicaFightingClubDuelStartText
	start_duel PRIZES_4, LOVE_TO_BATTLE_DECK_ID, MUSIC_DUEL_THEME_1
	quit_script_fully

Script_BeatJessicaInFightingClub:
	start_script
	print_npc_text JessicaFightingClubPlayerWon1Text
	give_booster_packs BOOSTER_COLOSSEUM_FIGHTING, BOOSTER_COLOSSEUM_FIGHTING, NO_BOOSTER
	print_npc_text JessicaFightingClubPlayerWon2Text
	quit_script_fully

Script_LostToJessicaInFightingClub:
	start_script
	print_text_quit_fully JessicaFightingClubPlayerLostText
