--[[ IN PROGRESS

// ENUS LOCALIZATION:

OL_EMMA[1] = "Seems like a hundred times a day I walk all the way to the well to get more water. No respect for their elders I tell ya.";
OL_EMMA[2] = "Jack and Jill my wrinkled patoot! I do all the water luggin' 'round here.";
OL_EMMA[3] = "Think I'm starting to wear a rut in the paving stones.";
OL_EMMA[4] = "One of these days I'm gonna drown him in that blue robe. And all his brooms too.";
OL_EMMA[5] = "Think I'm starting to wear a rut in the paving stones.";
OL_EMMA[6] = "O'course I'm talkin to myself. Only way to get decent conversation in this city.";
OL_EMMA[7] = "As if I don't have better things to do in my old age than carry buckets of water.";
OL_EMMA[8] = "Where's the water, Emma? Get the water, Emma? If'n it weren't fer me, that lot wouldn't know what water looks like.";
OL_EMMA[9] = "Deja vu.  For a moment, I thought I was back home... before the plague...";

--]]

local chat = {
"Seems like a hundred times a day I walk all the way to the well to get more water. No respect for their elders I tell ya.",
"Jack and Jill my wrinkled patoot! I do all the water luggin' 'round here.",
"Think I'm starting to wear a rut in the paving stones.",
"One of these days I'm gonna drown him in that blue robe. And all his brooms too.",
"Think I'm starting to wear a rut in the paving stones.",
"Por supuesto que estoy hablando conmigo misma. Es la única forma de tener una conversación decente en esta ciudad.",
"As if I don't have better things to do in my old age than carry buckets of water.",
"Where's the water, Emma? Get the water, Emma? If'n it weren't fer me, that lot wouldn't know what water looks like.",
"Deja vu.  Por un momento, pense que estaba de regreso en casa... antes de la plaga..."
};

OL_EMMA = {}

function OL_EMMA.Say1( unit, event )
		if( ( unit:IsAlive() == true ) and ( unit:IsInCombat() == false ) )
		then
        if( OL_EMMA.c < 5 )
        then
            OL_EMMA.c = OL_EMMA.c + 1;
				    unit:SendChatMessage( 12, 7, OL_EMMA[OL_EMMA.c] );
        else
            OL_EMMA.c = 0;
        end
		end
end

function OL_EMMA.Say2( unit, event )
		if( ( unit:IsAlive() == true ) and ( unit:IsInCombat() == false ) )
		then
        if( OL_EMMA.d < 10 )
        then
            OL_EMMA.d = OL_EMMA.d + 1;
            unit:SendChatMessage( 12, 7, chat[OL_EMMA.d] );
        else
            OL_EMMA.d = 4;
        end
    end
end

function OL_EMMA.OnSpawn( unit, event )
    OL_EMMA.c = 0;
    OL_EMMA.d = 4;
		unit:RegisterEvent( "OL_EMMA.Say1", 180000, 4 );
		unit:RegisterEvent( "OL_EMMA.Say2", 60000, 5 );
end

--RegisterUnitEvent( 3520, 18, "OL_EMMA.OnSpawn" );
