# Sécurité : on ne construit que si le chunk n'est PAS chargé en ce moment,
# ce qui réduit fortement le risque de spawn au milieu d'une construction active.
# (Ce n'est pas une garantie à 100%, juste le meilleur signal disponible en vanilla.)
execute unless loaded ~ ~ ~ run function customarmor:legendary/place_structure
