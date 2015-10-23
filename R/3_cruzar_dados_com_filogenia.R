### Como cruzar um banco de dados com sua filogenia?

### Início:---------------------------------------------------------------------

# pacotes necessários:
library(ape)
library(caper)
library(geiger)

### Carregar dados e filogenia: ------------------------------------------------
# Carregar árvore filogenética: 
arvore <- read.tree("filogenia/arvore.tre")

# Carregar banco de dados:
dados <- read.csv("dados/dados.csv")

# Confira as variáveis do banco de dados:
str(dados)
head(dados)

# Este banco de dados faz parte do pacote 'caper'.
# Para saber mais detalhes sobre o banco de dados e a filogenia (digite: ?shorebird)
###-----------------------------------------------------------------------------

### Cruzar dados e filogenia:---------------------------------------------------

# Primeiro associe o nome das espécies ao nome das linhas no bando de dados:
rownames(dados) <- dados$Species
head(dados)

# Testa se as espécies presentes no banco de dados estão na filogenia
# e se as espécies presentes na filogenia estão no banco de dados
name.check(arvore, dados) # Ok representa que os dados batem perfeitamente com a filogenia

# Caso alguma espécie da tabela de dados não esteja na filogenia ou
# alguma espécie da filogenia não estaje no bando de dados, esta função irá
# mostrar quais são essas espécies. Veja o exemplo abaixo (removendo uma 
# espécie da filogenia e uma espécie do bando de dados)

# Sem a espécie "Catoptrophorus_semipalmatus" na filogenia:
name.check(drop.tip(arvore, "Catoptrophorus_semipalmatus"), dados)

# Sem a espécie "Catoptrophorus_semipalmatus" nos dados:
name.check(arvore, dados[dados$Species != "Catoptrophorus_semipalmatus", ])

# Caso o seu banco de dados ou filogenia tenham espécies não congruentes,
# você precisa cortar essas espécies do banco de dados e/ou da filogenia:
# Os passos a seguir garantem que os dados e a filogenia estejam congruentes.
# Apenas utilize esses passos caso name.check não der "OK"!!!!

# Para ilustrar, vamos criamos o banco de dados e uma árvore com alumas espécies 
# faltando:
arvore2    <- drop.tip(arvore, 1:4) # Remove espécies de 1:4 da árvore
dados2     <- dados[-(1:7), ]       # Remove espécies de 1:7 do bando de dados

# name.check para detectar as diferenças:
nao.cruza  <- name.check(arvore2, dados2)
nao.cruza # Veja o que está faltando na filogenia e no banco de dados:

# Espécies presentes em ambos (dados/filogenia): 
ambos <- intersect(dados2$Species, arvore2$tip.label)
ambos

# União das espécies que não cruzam simultaneamente na árvore e nos dados:
remover <- c(nao.cruza$tree_not_data, nao.cruza$data_not_tree)
remover

# Quantas espécies serão removidas?
length(remover)

# Corta espécies da árvore:
arvore2 <- drop.tip(arvore2, remover)

# Corta espécies dos dados:
dados2 <- dados2[!dados2$Species %in% remover, ] 

# Verifica se deu certo:
name.check(arvore2, dados2)

# Por fim, verifique se a ordem das espécies é a mesma no banco de dados
# e na filogenia:
sum(dados2$Species == arvore2$tip.label) == length(dados2$Species)

# Se der "FALSE" é pq a ordem das espécies não é extamente a mesma entre 
# filogenia e os dados. 
# Para colocar filogenia e dados na mesma ordem:
tip.order <- match(arvore2$tip.label, rownames(dados2))
dados2 <- dados2[tip.order, ]

# Agora repita o teste (tem que dar "TRUE")
sum(dados2$Species == arvore2$tip.label) == length(dados2$Species)

# Parabéns, a sua filogenia e o seu banco de dados estão perfeitamente alinhados! :)
###-----------------------------------------------------------------------------

# Uma boa prática é juntar o banco de dados em um único objeto (opcional).
# Isso é interessante para evitar confusões e garantir que a espécie 1
# do banco de dados sempre seja igual a espécie 1 da filogenia.
# Para fazer isso vamos criar o objeto "da" (dados/arvore).
# Você pode dar o nome que quiser para "dados" e "arvore" dentro do objeto.

da <- list(dados = dados2, arvore = arvore2)
str(da)

# Sempre que quiser acessar os dados, utilize:
da$dados

# Sempre que quiser acessar a árvore, utilize:
da$arvore

### FIM-------------------------------------------------------------------------
