; filter types for CardTypeFilters
; used to categorise the different cards
; i.e. in the deck building screen
DEF FILTER_FIRE      EQUS "TYPE_PKMN_FIRE"
DEF FILTER_GRASS     EQUS "TYPE_PKMN_GRASS"
DEF FILTER_LIGHTNING EQUS "TYPE_PKMN_LIGHTNING"
DEF FILTER_WATER     EQUS "TYPE_PKMN_WATER"
DEF FILTER_FIGHTING  EQUS "TYPE_PKMN_FIGHTING"
DEF FILTER_PSYCHIC   EQUS "TYPE_PKMN_PSYCHIC"
DEF FILTER_COLORLESS EQUS "TYPE_PKMN_COLORLESS"
DEF FILTER_TRAINER   EQUS "TYPE_TRAINER"
DEF FILTER_ENERGY    EQU $20

DEF NUM_FILTERS EQU 9

DEF NUM_DECK_CONFIRMATION_VISIBLE_CARDS EQU 7
DEF NUM_CARD_ALBUM_VISIBLE_CARDS        EQU 7
DEF NUM_FILTERED_LIST_VISIBLE_CARDS     EQU 6
DEF NUM_DECK_MACHINE_VISIBLE_DECKS      EQU 5

; deck flags
	const_def
	const DECK_1_F ; $0
	const DECK_2_F ; $1
	const DECK_3_F ; $2
	const DECK_4_F ; $3

DEF DECK_1 EQU 1 << DECK_1_F ; $1
DEF DECK_2 EQU 1 << DECK_2_F ; $2
DEF DECK_3 EQU 1 << DECK_3_F ; $4
DEF DECK_4 EQU 1 << DECK_4_F ; $8

DEF ALL_DECKS EQU $ff

	const_def
	const DECK_MACHINE_SAVE      ; $0
	const DECK_MACHINE_FIGHTING  ; $1
	const DECK_MACHINE_ROCK      ; $2
	const DECK_MACHINE_WATER     ; $3
	const DECK_MACHINE_LIGHTNING ; $4
	const DECK_MACHINE_GRASS     ; $5
	const DECK_MACHINE_PSYCHIC   ; $6
	const DECK_MACHINE_SCIENCE   ; $7
	const DECK_MACHINE_FIRE      ; $8
	const DECK_MACHINE_BASIC     ; $9
	const DECK_MACHINE_LEGENDARY ; $a

DEF NUM_DECK_MACHINES EQU const_value - 1

DEF NUM_DECK_SAVE_MACHINE_SLOTS EQU 60
DEF NUM_DECK_MACHINE_SLOTS      EQU 5

; TODO find a way to not have these hardcoded?
DEF NUM_CARDS_COLOSSEUM   EQU 56
DEF NUM_CARDS_EVOLUTION   EQU 50
DEF NUM_CARDS_MYSTERY     EQU 51
DEF NUM_CARDS_LABORATORY  EQU 51
DEF NUM_CARDS_PROMOTIONAL EQU 20

; wOwnedPhantomCardFlags flags
	const_def
	const VENUSAUR_OWNED_PHANTOM_F ; $0
	const MEW_OWNED_PHANTOM_F      ; $1

; wStartMenuChoice enums
	const_def
	const START_MENU_CARD_POP            ; 0
	const START_MENU_CONTINUE_FROM_DIARY ; 1
	const START_MENU_NEW_GAME            ; 2
	const START_MENU_CONTINUE_DUEL       ; 3

DEF NUM_MAILS EQU 15

; TextDelaySettings constants
DEF TEXT_SPEED_1 EQU 6
DEF TEXT_SPEED_2 EQU 4
DEF TEXT_SPEED_3 EQU 2
DEF TEXT_SPEED_4 EQU 1
DEF TEXT_SPEED_5 EQU 0
