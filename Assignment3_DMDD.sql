Assignment 3 – DAMG_6210  - DMDD  				Anmol Sharma

set serveroutput on;

DECLARE
  latest NUMBER;
BEGIN
  SELECT count(*) INTO latest FROM user_tables 
    WHERE TABLE_NAME = 'TICTACTOE';
  IF latest = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE game_tictactoe(
      y NUMBER,
      A CHAR,
      B CHAR,
      C CHAR
    )';
 END IF;
END;

SELECT * FROM game_tictactoe;

CREATE OR REPLACE FUNCTION aToCol(a IN NUMBER)
RETURN CHAR
IS
BEGIN
  IF a=1 THEN
    RETURN 'A';
  ELSIF a=2 THEN
    RETURN 'B';
  ELSIF a=3 THEN
    RETURN 'C';
  ELSE 
    RETURN '_';
  END IF;
END;

CREATE OR REPLACE PROCEDURE create_board IS
BEGIN
  dbms_output.enable(10000);
  dbms_output.put_line(' ');
  FOR ll in (SELECT * FROM game_tictactoe ORDER BY Y) LOOP
    dbms_output.put_line('     ' || ll.A || ' ' || ll.B || ' ' || ll.C);
  END LOOP; 
  dbms_output.put_line(' ');
END;

CREATE OR REPLACE PROCEDURE restart_board IS
b NUMBER;
BEGIN
  DELETE FROM game_tictactoe;
  FOR b in 1..3 LOOP
    INSERT INTO game_tictactoe VALUES (b,'_','_','_');
  END LOOP; 
  dbms_output.enable(10000);
  create_board();
  dbms_output.put_line('The game is restarted -> to play: EXECUTE play(''X'', x, y);');
END;

CREATE OR REPLACE PROCEDURE play(tag IN VARCHAR2, col IN NUMBER, line IN NUMBER) IS
val game_tictactoe.a%type;
c CHAR;
tag_1 CHAR;
BEGIN
  SELECT aToCol(col) INTO c FROM DUAL;
  EXECUTE IMMEDIATE ('SELECT ' || c || ' FROM game_tictactoe WHERE y=' || line) INTO val;
  IF val='_' THEN
    EXECUTE IMMEDIATE ('UPDATE game_tictactoe SET ' || c || '=''' || tag || ''' WHERE y=' || line);
    IF tag='X' THEN
      tag_1:='O';
    ELSE
      tag_1:='X';
    END IF;
    create_board();
    dbms_output.put_line('To Play -> EXECUTE play(''' || tag_1 || ''', x, y);');
  ELSE
    dbms_output.enable(10000);
    dbms_output.put_line('This step is already played');
  END IF;
END;
 
CREATE OR REPLACE PROCEDURE champ(tag IN VARCHAR2) IS
BEGIN
  dbms_output.enable(10000);
  create_board();
  dbms_output.put_line('You' || tag || 'Won'); 
  dbms_output.put_line('---------------------------------------');
  dbms_output.put_line('Starting game again');
  restart_board();
END;

CREATE OR REPLACE FUNCTION win_req(d IN VARCHAR2, tag IN VARCHAR2)
RETURN VARCHAR2
IS
BEGIN
  RETURN ('SELECT COUNT(*) FROM game_tictactoe WHERE ' || d || ' = '''|| tag ||''' AND ' || d || ' != ''_''');
END;

CREATE OR REPLACE FUNCTION cross_req(d IN VARCHAR2, yvalue IN NUMBER)
RETURN VARCHAR2
IS
BEGIN
  RETURN ('SELECT '|| d ||' FROM game_tictactoe WHERE y=' || yvalue);
END;

-- Test Functions

CREATE OR REPLACE FUNCTION winnercol(d IN VARCHAR2)
RETURN CHAR
IS
  awin NUMBER;
  r VARCHAR2(56);
BEGIN
  SELECT win_req(d, 'X') into r FROM DUAL;
  EXECUTE IMMEDIATE r INTO awin;
  IF awin=3 THEN
    RETURN 'X';
  ELSIF awin=0 THEN
    SELECT win_req(d, 'O') into r FROM DUAL;
    EXECUTE IMMEDIATE r INTO awin;
    IF awin=3 THEN
      RETURN 'O';
    END IF;
  END IF;
  RETURN '_';
END;

CREATE OR REPLACE FUNCTION winnercross(temp IN CHAR, numcol IN NUMBER, numline IN NUMBER)
RETURN CHAR
IS
  e CHAR;
  f CHAR;
  r VARCHAR2(56);
BEGIN
  SELECT cross_req(aToCol(numcol), numline) INTO r FROM DUAL;
  IF temp IS NULL THEN
    EXECUTE IMMEDIATE (r) INTO f;
  ELSIF NOT temp = '_' THEN
    EXECUTE IMMEDIATE (r) INTO e;
    IF NOT temp = e THEN
      f := '_';
    END IF;
  ELSE
    f := '_';
  END IF;
  RETURN f;
END;

CREATE OR REPLACE TRIGGER isWinner
AFTER UPDATE ON game_tictactoe
DECLARE
  CURSOR cr_line IS 
    SELECT * FROM game_tictactoe ORDER BY Y; 
  cr_a game_tictactoe%rowtype;
  e CHAR;
  g CHAR;
  h CHAR;
  r VARCHAR2(40);
BEGIN
  FOR cr_a IN cr_line LOOP
    -- line test

    IF cr_a.A = cr_a.B AND cr_a.B = cr_a.C AND NOT cr_a.A='_' THEN
      champ(cr_a.A);
      EXIT;
    END IF;
    -- colon test

    SELECT winnercol(aToCol(cr_a.Y)) INTO e FROM DUAL;
    IF NOT e = '_' THEN
      champ(e);
      EXIT;
    END IF;
    -- diagonal test
    SELECT winnercross(g, cr_a.Y, cr_a.Y) INTO g FROM dual;
    SELECT winnercross(h, 4-cr_a.Y, cr_a.Y) INTO h FROM dual;
  END LOOP;
  IF NOT g = '_' THEN
    champ(g);
  END IF;
  IF NOT h = '_' THEN
    champ(h);
  END IF;
END;

EXECUTE restart_board;
EXECUTE play('X', 1, 3);
EXECUTE play('O', 2, 1);
EXECUTE play('X', 2, 2);
EXECUTE play('O', 2, 3);
EXECUTE play('X', 3, 1);
