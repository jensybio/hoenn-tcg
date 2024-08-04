AIActionTable_ZappingSelfdestruct:
	dw .do_turn ; unused
	dw .do_turn
	dw .start_duel
	dw .forced_switch
	dw .ko_switch
	dw .take_prize

.do_turn
	call AIMainTurnLogic
	ret

.start_duel
	call InitAIDuelVars
	call .store_list_pointers
	call SetUpBossStartingHandAndDeck
	call TrySetUpBossStartingPlayArea
	ret nc
	call AIPlayInitialBasicCards
	ret

.forced_switch
	call AIDecideBenchPokemonToSwitchTo
	ret

.ko_switch
	call AIDecideBenchPokemonToSwitchTo
	ret

.take_prize
	call AIPickPrizeCards
	ret

.list_arena
	db CRAWDAUNT
	db NOSEPASS
	db ABSOL
	db MAGNEMITE
	db VOLTORB
	db $00

.list_bench
	db MAGNEMITE
	db VOLTORB
	db NOSEPASS
	db ABSOL
	db CRAWDAUNT
	db $00

.list_retreat
	ai_retreat VOLTORB, -1
	db $00

.list_energy
	ai_energy MAGNEMITE,  3, +1
	ai_energy REGISTEEL,   4, +0
	ai_energy VOLTORB,         3, +1
	ai_energy ELECTRODE,  3, +0
	ai_energy NOSEPASS, 1, +0
	ai_energy CRAWDAUNT,      2, -2
	ai_energy ABSOL,          3, +0
	db $00

.list_prize
	db CRAWDAUNT
	db $00

.store_list_pointers
	store_list_pointer wAICardListAvoidPrize, .list_prize
	store_list_pointer wAICardListArenaPriority, .list_arena
	store_list_pointer wAICardListBenchPriority, .list_bench
	store_list_pointer wAICardListPlayFromHandPriority, .list_bench
	store_list_pointer wAICardListRetreatBonus, .list_retreat
	store_list_pointer wAICardListEnergyBonus, .list_energy
	ret
