# Déclenché quand le Marteau Sismique casse un bloc.
# On utilise la position mémorisée par pickaxe_track (avant que le bloc casse),
# donc pas de risque de viser un bloc décalé.
function customarmor:pickaxe_mine_at with storage customarmor:cache

advancement revoke @s only customarmor:pickaxe_hit
