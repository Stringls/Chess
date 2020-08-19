﻿namespace Chess.Data.Models
{
    using Chess.Common;
    using Chess.Common.Enums;
    using Chess.Data.Models.Pieces;
    using Chess.Data.Models.Pieces.Contracts;
    using Chess.Data.Models.Pieces.Helpers;

    public class Factory
    {
        public static Board GetBoard()
        {
            return new Board();
        }

        public static Player GetPlayer(string name, string connectionId)
        {
            return new Player(name, connectionId);
        }

        public static IPiece GetPawn(Color color)
        {
            return new Pawn(color);
        }

        public static IPiece GetRook(Color color)
        {
            return new Rook(color);
        }

        public static IPiece GetKnight(Color color)
        {
            return new Knight(color);
        }

        public static IPiece GetBishop(Color color)
        {
            return new Bishop(color);
        }

        public static IPiece GetQueen(Color color)
        {
            return new Queen(color);
        }

        public static IPiece GetKing(Color color)
        {
             return new King(color);
        }

        public static IPiece GetEmpty()
        {
            return new Empty();
        }

        public static Position GetPosition()
        {
            return new Position();
        }

        public static Position GetPosition(int y, int x)
        {
            return new Position(y, x);
        }

        public static Square GetSquare()
        {
            return new Square();
        }

        public static Square GetSquare(int x, int y)
        {
            return new Square(x, y);
        }

        public static Square[][] GetMatrix()
        {
            Square[][] matrix = new Square[GlobalConstants.BoardRows][];

            for (int row = 0; row < GlobalConstants.BoardRows; row++)
            {
                matrix[row] = new Square[GlobalConstants.BoardCols];
            }

            return matrix;
        }

        public static RookBehaviour GetRookBehaviour()
        {
            return new RookBehaviour();
        }

        public static BishopBahaviour GetBishopBehaviour()
        {
            return new BishopBahaviour();
        }

        public static Game GetGame(Player player1, Player player2)
        {
            return new Game(player1, player2);
        }

        public static Move GetMove()
        {
            return new Move();
        }
    }
}
