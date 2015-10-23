### Como manipular árvores filognéticas?

### Início:---------------------------------------------------------------------

# pacotes necessários:
library(ape)

# Como carregar um árvore filogenética no R? -----------------------------------
# A função 'read.tree()' lê árvores no formato (Newick)
arvore <- read.tree("filogenia/tree.tre")

# Confira se a árvore foi carregada corretamente (número de espécies,
# número de nós, nome das espécies, se a árvore é enraizada e se
# possui informações sobre o comprimento dos ramos)
arvore

# Veja a lista de espécies da sua árvore:
arvore$tip.label

# Veja o comprimento dos ramos:
arvore$edge.length

# Como verificar se a árvore é ultramétrica?
is.ultrametric(arvore)

# Como verificar se a árvore é enraizada?
is.rooted(arvore)

# Como remover uma/várias espécies da árvore? ----------------------------------
drop.tip(arvore, arvore$tip.label[1])   # remove a primeira espécies da árvore
drop.tip(arvore, arvore$tip.label[1:5]) # remove as cinco primeiras espécies
drop.tip(arvore, "Tringa_glareola")     # remove a espécies "Tringa_glareola"

# Depois de remover as espécies que deseja, você pode salvar a árvore em um objeto:
arvore2 <- drop.tip(arvore, "Tringa_glareola")
arvore2   # perceba que agora a árvore possui 70 espécies (em vez de 71)

# Para exportar a árvore em formato Newwick, utilize a função 'write.tree()'
write.tree(phy = arvore2, file = "arvore2.tre")

# Como visualizar a árvore (básico)---------------------------------------------
plot(arvore, cex = .5)                # cex regula o tamanho da fonte 
plot(arvore, show.tip.label = F)      # esconde os nomes
plot(arvore, type = "fan", cex = .5)  # Plota uma árvore circular
