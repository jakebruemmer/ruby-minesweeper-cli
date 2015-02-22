mkdir $HOME/.minesweeper
mv minesweeper* game* $HOME/.minesweeper/
cd $HOME/.minesweeper/

chmod +x ./minesweeper.rb

mv minesweeper.rb minesweeper

sudo ln -s $PWD/minesweeper /usr/local/bin
