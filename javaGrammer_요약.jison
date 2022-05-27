%token ABSTRACT ASSERT
%token BOOLEAN BREAK BYTE
%token CASE CATCH CHAR CLASS CONST CONTINUE
%token DEFAULT DO DOUBLE
%token ELSE ENUM EXTENDS
%token FINAL FINALLY FLOAT FOR
%token IF
%token GOTO
%token IMPLEMENTS IMPORT INSTANCEOF INT INTERFACE
%token LONG
%token NATIVE NEW
%token PACKAGE PRIVATE PROTECTED PUBLIC
%token RETURN
%token SHORT STATIC STRICTFP SUPER SWITCH SYNCHRONIZED
%token THIS THROW THROWS TRANSIENT TRY VOID VOLATILE WHILE

%token IntegerLiteral FloatingPointLiteral BooleanLiteral CharacterLiteral StringLiteral NullLiteral

%token LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK SEMI COMMA DOT

%token ASSIGN GT LSHIFT LT BANG TILDE QUESTION COLON EQUAL LE GE NOTEQUAL AND OR INC DEC ADD SUB MUL DIV BITAND BITOR CARET MOD
%token ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN AND_ASSIGN OR_ASSIGN XOR_ASSIGN MOD_ASSIGN LSHIFT_ASSIGN RSHIFT_ASSIGN URSHIFT_ASSIGN

%token AT ELLIPSIS

%token Identifier

%token TEMPLATE

%token EOF

%left LSHIFT TEMPLATE

%left MOD
%left MUL DIV
%left ADD SUB

%right ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN AND_ASSIGN OR_ASSIGN XOR_ASSIGN RSHIFT_ASSIGN URSHIFT_ASSIGN LSHIFT_ASSIGN MOD_ASSIGN

%start compilationUnit


%%
compilationUnit
    :	packageDeclaration EOF
    |   packageDeclaration importDeclarations EOF
    |   packageDeclaration importDeclarations typeDeclarations EOF
    |	packageDeclaration typeDeclarations EOF
    |	importDeclarations typeDeclarations EOF
    |	typeDeclarations EOF
    |   SEMI
    ;

packageDeclaration
    :	annotationl packageDeclaration
    |   packageDeclaration
    ;

packageDeclaration
    :   PACKAGE qualifiedName SEMI
    ;

importDeclarations
    :   importDeclaration
    |   importDeclarations importDeclaration
    ;

importDeclaration
    :   IMPORT STATIC qualifiedName DOT MUL SEMI
    |   IMPORT STATIC qualifiedName SEMI
    |	IMPORT qualifiedName DOT MUL SEMI
    |   IMPORT qualifiedName SEMI
    ;

typeDeclarations
    :   typeDeclarationWithPrefixes
    |   typeDeclarations typeDeclarationWithPrefixes
    ;

typeDeclarationWithPrefixes
    :   annotationl modifierL typeDeclaration
    |   modifierL annotationl typeDeclaration
    |   modifierL typeDeclaration
    |   annotationl typeDeclaration
    |   typeDeclaration
    ;

typeDeclaration
    :   classDeclaration
    |   interfaceDeclaration
    |   enumDeclaration
    |   annotationTypeDeclaration
    |   SEMI
    ;

classDeclaration
    :   CLASS Identifier classInheritance interfaceImplentation commentReturn classBody
    |   CLASS Identifier typeParameters classInheritance interfaceImplentation commentReturn classBody
    ;

classInheritance
    :   %empty /* empty */

    |   EXTENDS type
    ;

interfaceImplentation
    :   %empty /* empty */
    |   IMPLEMENTS typeList
    ;

typeParameters
    :   TEMPLATE
    ;

enumDeclaration
    :   ENUM Identifier interfaceImplentation commentReturn enumBody
    ;

enumBody
    :   LBRACE RBRACE
    |   LBRACE enumBodyDeclaration RBRACE
    ;

enumBodyDeclaration
    :   enumConstants
    |   enumConstants COMMA
    |   enumConstants SEMI
    |   enumConstants COMMA SEMI
    |   enumConstants SEMI classBodyDeclarationl
    |   enumConstants COMMA SEMI classBodyDeclarationl
    ;

enumConstants
    :   annotations Identifier enumConstantArguments commentReturn enumConstantClassBody
    |   enumConstants COMMA annotations Identifier enumConstantArguments commentReturn enumConstantClassBody
    ;

enumConstantArguments
    :   %empty /* empty */
    |   arguments
    ;
enumConstantClassBody
    :   %empty /* empty */
    |   classBody
    ;

interfaceDeclaration
    :   INTERFACE Identifier optionalTypeParameters commentReturn interfaceBody
    |   INTERFACE Identifier optionalTypeParameters EXTENDS typeList commentReturn interfaceBody
    ;

typeList
    :   type
    |   typeList COMMA type
    ;

optionalTypeParameters
    :   %empty
    |   typeParameters
    ;
classBody
    :   LBRACE  RBRACE
    |   LBRACE classBodyDeclarationl RBRACE
    ;

/*Can be zero or more*/
classBodyDeclarations
    :   %empty /* empty */
    |   classBodyDeclarationl
    ;

classBodyDeclarationl
    :   classBodyDeclaration
    |   classBodyDeclarationl classBodyDeclaration
    ;

classStaticBlock
    :   STATIC block
    |   block     /* check openjdk/jdk/src/share/classes/com/sun/java/util/jar/pack/Package.java:62 */
    ;

interfaceBody
    :   LBRACE RBRACE
    |   LBRACE interfaceBodyDeclarationl RBRACE
    ;

interfaceBodyDeclarations
    :   %empty /* empty */
    |   interfaceBodyDeclarationl
    ;

interfaceBodyDeclarationl
    :   interfaceBodyDeclaration
    |   interfaceBodyDeclarationl interfaceBodyDeclaration
    ;

classBodyDeclaration
    :   SEMI
    |   annotationl modifierL classMemberDeclaration
    |   modifierL annotationl classMemberDeclaration
    |   modifierL classMemberDeclaration
    |   annotationl classMemberDeclaration
    |   classMemberDeclaration
    |   classStaticBlock
    ;

staticBlock
    : %empty /* empty */
    | STATIC block
    ;

modifier
    :   STATIC
    |   FINAL
    |   ABSTRACT
    |   STRICTFP
    |   TRANSIENT
    |   VOLATILE
    |   PUBLIC
    |   PRIVATE
    |   PROTECTED
    |   NATIVE
    |   SYNCHRONIZED
    ;

modifierL
    :   modifier
    |   modifierL modifier
    ;

modifiers
    :   %empty /* empty */
    |   modifierL
    ;

classMemberDeclaration
    :   /* Methods */
        VOID Identifier formalParameters arrayDimensionBracks throwsList commentReturn block
    |   VOID Identifier formalParameters arrayDimensionBracks commentReturn block
    |   VOID Identifier formalParameters commentReturn block
    |   type Identifier formalParameters arrayDimensionBracks throwsList commentReturn block
    |   type Identifier formalParameters arrayDimensionBracks commentReturn block
    |   type Identifier formalParameters commentReturn block
    |   VOID Identifier formalParameters arrayDimensionBracks throwsList commentReturn SEMI
    |   VOID Identifier formalParameters arrayDimensionBracks commentReturn SEMI
    |   VOID Identifier formalParameters commentReturn SEMI
    |   type Identifier formalParameters arrayDimensionBracks throwsList commentReturn SEMI
    |   type Identifier formalParameters arrayDimensionBracks commentReturn SEMI
    |   type Identifier formalParameters commentReturn SEMI
    |   typeParameters VOID Identifier formalParameters arrayDimensionBracks throwsList commentReturn block
    |   typeParameters VOID Identifier formalParameters arrayDimensionBracks commentReturn block
    |   typeParameters VOID Identifier formalParameters commentReturn block
    |   typeParameters type Identifier formalParameters arrayDimensionBracks throwsList commentReturn block
    |   typeParameters type Identifier formalParameters arrayDimensionBracks commentReturn block
    |   typeParameters type Identifier formalParameters commentReturn block
    |   typeParameters VOID Identifier formalParameters arrayDimensionBracks throwsList commentReturn SEMI
    |   typeParameters VOID Identifier formalParameters arrayDimensionBracks commentReturn SEMI
    |   typeParameters VOID Identifier formalParameters commentReturn SEMI
    |   typeParameters type Identifier formalParameters arrayDimensionBracks throwsList commentReturn SEMI
    |   typeParameters type Identifier formalParameters arrayDimensionBracks commentReturn SEMI
    |   typeParameters type Identifier formalParameters commentReturn SEMI
    /* Fields */
    |   type variableDeclarators commentReturn SEMI
    /* Constructor */
    |   Identifier formalParameters throwsList commentReturn block
    |   typeParameters Identifier formalParameters throwsList commentReturn block
    /* Inner class, enum, interface or annotation type */
    |   classDeclaration
    |   interfaceDeclaration
    |   enumDeclaration
    |   annotationTypeDeclaration
    ;

throwsList
    : %empty /* empty */
    |   THROWS qualifiedNameList
    ;

interfaceBodyDeclaration
    :   annotationl modifierL interfaceMemberDeclaration
    |   modifierL annotationl interfaceMemberDeclaration
    |   annotationl interfaceMemberDeclaration
    |   modifierL interfaceMemberDeclaration
    |   interfaceMemberDeclaration
    |   SEMI
    ;

interfaceMemberDeclaration
    :   type constDelarators commentReturn SEMI
    |   VOID Identifier formalParameters arrayDimensionBracks throwsList commentReturn SEMI
    |   VOID Identifier formalParameters arrayDimensionBracks commentReturn SEMI
    |   VOID Identifier formalParameters commentReturn SEMI
    |   type Identifier formalParameters arrayDimensionBracks throwsList commentReturn SEMI
    |   type Identifier formalParameters arrayDimensionBracks commentReturn SEMI
    |   type Identifier formalParameters commentReturn SEMI
    |   typeParameters VOID Identifier formalParameters arrayDimensionBracks throwsList commentReturn SEMI
    |   typeParameters VOID Identifier formalParameters arrayDimensionBracks commentReturn SEMI
    |   typeParameters VOID Identifier formalParameters commentReturn SEMI
    |   typeParameters type Identifier formalParameters arrayDimensionBracks throwsList commentReturn SEMI
    |   typeParameters type Identifier formalParameters arrayDimensionBracks commentReturn SEMI
    |   typeParameters type Identifier formalParameters commentReturn SEMI
    |   classDeclaration
    |   interfaceDeclaration
    |   enumDeclaration
    |   annotationTypeDeclaration
    ;

constDeclaration
    :   constDelarators SEMI
    ;

constDelarators
    :   constantDeclarator
    |   constDelarators COMMA constantDeclarator
    ;

constantDeclarator
    :   Identifier ASSIGN variableInitializer
    |   Identifier arrayDimensionBrackl ASSIGN variableInitializer
    ;

variableDeclarators
    :   variableDeclarator
    |   variableDeclarators COMMA variableDeclarator
    ;

variableDeclarator
    :   variableDeclaratorId
    |   variableDeclaratorId ASSIGN variableInitializer
    ;

variableDeclaratorId
    :   Identifier arrayDimensionBracks
    ;

variableInitializer
    :   arrayInitializer
    |   expression
    ;

arrayInitializer
    :   LBRACE RBRACE /*(variableInitializerL (",")? )?*/

    |   LBRACE variableInitializerL SEMI RBRACE

    |   LBRACE variableInitializerL RBRACE

    |   LBRACE variableInitializerL COMMA RBRACE

    ;

variableInitializerL
    :   variableInitializer
    |   variableInitializerL COMMA variableInitializer
    ;

enumConstantName
    :   qualifiedName
    ;

type
    :   qualifiedName arrayDimensionBracks
    |   primitiveType arrayDimensionBracks
    ;

arrayDimensionBracks
    :   %empty /* empty */
    |   arrayDimensionBrackl
    ;

arrayDimensionBrackl
    :   arrayDimensionBrack
    |   arrayDimensionBrackl arrayDimensionBrack
    ;

arrayDimensionBrack
    :   LBRACK RBRACK
    ;
classOrInterfaceType
    :   qualifiedName
    |   qualifiedName typeParameters
    ;

primitiveType
    :   BOOLEAN
    |   CHAR
    |   BYTE
    |   SHORT
    |   INT
    |   LONG
    |   FLOAT
    |   DOUBLE
    ;

typeArguments
    :   %empty /* empty */
    |   LT typeArgumentList GT
    ;

typeArgumentList
    :   typeArgument
    |   typeArgumentList COMMA typeArgument
    ;

typeArgument
    :   type
    |   QUESTION EXTENDS type
    |   QUESTION SUPER type
    ;

typeArgument_
    : %empty /* empty */
    |   EXTENDS type
    |   SUPER type
    ;

qualifiedNameList
    :   qualifiedName
    |   qualifiedNameList COMMA qualifiedName
    ;

formalParameters
    :   LPAREN RPAREN
    |   LPAREN formalParameterList RPAREN
    ;

formalParameterList
    :   usualParameterList
    |   usualParameterList COMMA lastFormalParameter
    |   lastFormalParameter
    ;

usualParameterList
    :   usualParameter
    |   usualParameterList COMMA usualParameter
    ;

variableModifiers
    :   FINAL annotationl
    |   annotationl
    |   FINAL
    |   annotationl FINAL
    ;

variableModifierL
    :   variableModifier
    |   variableModifierL variableModifier
    ;

variableModifier
    :   FINAL
    |   annotations
    ;

usualParameter
    :   variableModifiers type variableDeclaratorId
    |   type variableDeclaratorId
    ;

lastFormalParameter
    :   variableModifiers type ELLIPSIS variableDeclaratorId
    |   type ELLIPSIS variableDeclaratorId
    ;

methodBody
    :   block
    ;

constructorBody
    :   block
    ;

qualifiedName
    :   Identifier
    |   Identifier typeParameters
    |   qualifiedName DOT Identifier
    |   qualifiedName DOT Identifier typeParameters
    ;

literal
    :   IntegerLiteral
    |   FloatingPointLiteral
    |   CharacterLiteral
    |   StringLiteral
    |   BooleanLiteral
    |   NullLiteral
    ;

/* ANNOTATIONS */

annotations
    :   %empty /* empty */
    |   annotationl
    ;

annotationl
    :   annotation
    |   annotationl annotation
    ;

annotation
    :   AT qualifiedName
    |   AT qualifiedName LPAREN elementValueList RPAREN
    |   AT qualifiedName LPAREN elementValuePairs RPAREN
    ;

annotationOptValues
    :   %empty /* empty */
    |   LPAREN annotationElement RPAREN
    ;

annotationElement
    :   %empty /* empty */
    |   elementValuePairs
    |   elementValue
    ;
annotationName
    :   qualifiedName
    ;

elementValuePairs
    :   elementValuePair
    |   elementValuePairs COMMA elementValuePair
    ;

elementValuePair
    :   Identifier ASSIGN elementValue
    ;

elementValue
    :   expression
    |   annotations
    |   LBRACE RBRACE /*(elementValue ("," elementValue)*)? (",")?*/
    |   LBRACE elementValueList RBRACE
    ;

elementValueArrayInitializer
    :   LBRACE RBRACE /*(elementValue ("," elementValue)*)? (",")?*/
    |   LBRACE elementValueList RBRACE
    ;

elementValueListOpt
    :   %empty /* empty */
    |   elementValueList
    ;

elementValueList
    :   elementValue
    |   elementValueList COMMA elementValue
    ;

annotationTypeDeclaration
    :   AT INTERFACE Identifier commentReturn annotationTypeBody
    |   AT INTERFACE Identifier EXTENDS typeList commentReturn annotationTypeBody
    ;

annotationTypeBody
    :   LBRACE RBRACE
    |   LBRACE annotationTypeElementDeclarations RBRACE
    ;


annotationTypeElementDeclarations
    :   annotationTypeElementDeclaration
    |   annotationTypeElementDeclarations annotationTypeElementDeclaration
    ;

annotationTypeElementDeclaration
    :   modifierL annotationTypeElementRest
    |   annotationl annotationTypeElementRest
    |   annotationl modifierL annotationTypeElementRest
    |   modifierL annotationl annotationTypeElementRest
    |   annotationTypeElementRest
    |   SEMI /* this is not allowed by the grammar, but apparently allowed by the actual compiler*/
    ;

annotationTypeElementRest
    :   type annotationConstantRest commentReturn SEMI
    |   typeParameters type annotationMethodRest commentReturn SEMI
    |   type annotationMethodRest commentReturn SEMI
    |   classDeclaration
    |   interfaceDeclaration
    |   enumDeclaration
    |   annotationTypeDeclaration
    ;

semiOpt
    :   %empty /* empty */
    |   SEMI
    ;

annotationMethodRest
    :   Identifier LPAREN RPAREN defaultValue
    |   Identifier LPAREN RPAREN
    ;

defaultValueOpt
    :   %empty /* empty */
    |   defaultValue
    ;

annotationConstantRest
    :   variableDeclarators
    ;

defaultValue
    :   DEFAULT elementValue
    ;

/* STATEMENTS / BLOCKS */

block
    :   LBRACE RBRACE
    |   LBRACE blockStatementList RBRACE

    ;

blockStatements
    :   %empty /* empty */
    |   blockStatementList
    ;

blockStatementList
    :   blockStatement
    |   blockStatementList blockStatement
    ;

blockStatement
    :   statement
    /*|   typeDeclaration */
    |   LBRACE RBRACE

    |   LBRACE blockStatementList RBRACE

    ;

localVariableDeclarationStatement
    :   localVariableDeclaration SEMI
    ;

localVariableDeclaration
    :   type variableDeclarators
    ;

assertExpression
    :   expression
    |   expression COLON expression
    ;

optionalElseStatement
    :   %empty /* empty */
    |   ELSE blockStatement
    ;

statement
    :   ASSERT assertExpression SEMI
    |   IF LPAREN expression RPAREN blockStatement optionalElseStatement
/*       % {console.log('IF block'); %} */
    |   FOR LPAREN forControl RPAREN blockStatement
    |   WHILE LPAREN expression RPAREN blockStatement
    |   DO blockStatement WHILE LPAREN expression RPAREN SEMI
    |   TRY block catchFinallyOrOnlyFinally
    |   TRY resourceSpecification block catchClauses
    |   TRY resourceSpecification block optionalFinallyBlock
    |   TRY resourceSpecification block catchClauses optionalFinallyBlock
    |   SWITCH LPAREN expression RPAREN LBRACE switchBlockStatementGroups emptySwitchLabels RBRACE
    |   SYNCHRONIZED LPAREN expression RPAREN block
    |   RETURN SEMI
    |   RETURN expression SEMI
    |   THROW expression SEMI
    |   BREAK optionalIdentifier SEMI
    |   CONTINUE optionalIdentifier SEMI
/*    |   SEMI*/
    |   Identifier COLON blockStatement
    |   expression SEMI
    |   typeDeclarationWithPrefixes /*Refer openjdk/hotspot/agent/src/share/classes/sun/jvm/hotspot/tools/PermStat.java:70 */
    |   variableDeclaratorsWithPrefixes
    /*|   LBRACE RBRACE
        { console.log('Found empty code block')}
    |   LBRACE blockStatementList RBRACE
        { console.log('Found code block')} */
    ;

variableDeclaratorsWithPrefixes
    :   annotationl modifierL localVariableDeclaration
    |   modifierL annotationl localVariableDeclaration
    |   modifierL localVariableDeclaration
    |   annotationl localVariableDeclaration
    |   localVariableDeclaration
    ;

simpleExpressionStatement
    :   expression SEMI
    ;
optionalIdentifier
    :   %empty /* empty */
    |   Identifier
    ;

catchFinallyOrOnlyFinally
    :   catchClauses optionalFinallyBlock
    |   finallyBlock
    ;

optionalFinallyBlock
    :   %empty /* empty */
    |   finallyBlock
    ;
catchClauses
    :   catchClause
    |   catchClauses catchClause
    ;

catchClause
    :   CATCH LPAREN variableModifiers catchType Identifier RPAREN block
    |   CATCH LPAREN catchType Identifier RPAREN block
    ;

catchType
    :   qualifiedName
    |   catchType BITOR qualifiedName
    ;

finallyBlock
    :   FINALLY block
    ;

resourceSpecification
    :   LPAREN resources semiOpt RPAREN
    ;

resources
    :   resource
    |   resources SEMI resource
    ;

resource
    :   variableModifiers classOrInterfaceType variableDeclaratorId ASSIGN expression
    |   classOrInterfaceType variableDeclaratorId ASSIGN expression
    ;


switchBlockStatementGroups
    :   %empty /* empty */
    |   switchBlockStatementGroupL
    ;

switchBlockStatementGroupL
    :   switchBlockStatementGroup
    |   switchBlockStatementGroupL switchBlockStatementGroup
    ;

switchBlockStatementGroup
    :   switchLabelL blockStatementList
    |   switchLabelL
    ;

emptySwitchLabels
    :   %empty /* empty */
    |   switchLabelL
    ;

switchLabelL
    :   switchLabel
    |   switchLabelL switchLabel
    ;

switchLabel
    :   CASE expression COLON /* openjdk/jdk/src/share/classes/com/sun/java/util/jar/pack/BandStructure.java:2421 */
    /*|   CASE enumConstantName COLON*/
    |   DEFAULT COLON
    ;

forControl
    :   enhancedForControl

    |   forInit SEMI optionalExpression SEMI optionalForUpdate
    |   SEMI optionalExpression SEMI optionalForUpdate
    ;

optionalForInit
    :   %empty /* empty */
    |   forInit
    ;

optionalExpression
    :   %empty /* empty */
    |   expression
    ;

optionalForUpdate
    :   %empty /* empty */
    |   forUpdate
    ;

forInit
    :   variableDeclaratorsWithPrefixes
    |   expressionList
    ;

enhancedForControl
    :   modifierL type variableDeclaratorId COLON expression
    |   type variableDeclaratorId COLON expression
    ;

forUpdate
    :   expressionList
    ;

/* EXPRESSIONS */

parExpression
    :   LPAREN expression RPAREN
    ;

expressionList
    :   expression
    |   expressionList COMMA expression
    ;

optionalExpressionList
    :   %empty /* empty */
    |   expressionList
    ;
statementExpression
    :   expression
    ;

constantExpression
    :   expression
    ;

optionalNonWildcardTypeArguments
    :   %empty /* empty */
    |   nonWildcardTypeArguments
    ;

/* Postfix inc or dec */
incrementOrDecrement
    :   INC
    |   DEC
    ;

/* Prefix arithmetic unary operators */

plusMinusIncOrDec
    :   ADD
    |   SUB
    |   INC
    |   DEC
    ;

prefixTildeOrBang
    :   TILDE
    |   BANG
    ;

/* Binary operators */
mulDivOrMod
    :   MUL
    |   DIV
    |   MOD
    ;

addOrSub
    :   ADD
    |   SUB
    ;

bitShiftOperator
    :   LT LT           /* << left shift */
    |   GT GT GT        /* >>> unsigned right shift */
    |   GT GT           /* right shift */
    ;
lE_GE_LT_GT
    :   LE
    |   GE
    |   GT
    |   LT
    ;

equals_NotEqual
    :   EQUAL
    |   NOTEQUAL
    ;

assignmentToken
    :   ASSIGN
    |   ADD_ASSIGN
    |   SUB_ASSIGN
    |   MUL_ASSIGN
    |   DIV_ASSIGN
    |   AND_ASSIGN
    |   OR_ASSIGN
    |   XOR_ASSIGN
    |   RSHIFT_ASSIGN
    |   URSHIFT_ASSIGN
    |   LSHIFT_ASSIGN
    |   MOD_ASSIGN
    ;

newCreator
    :   NEW creator
    ;


/* THIS RULE IS TO JUST RETURN JAVADOC COMMENT */
commentReturn
    :   %empty
    ;


expression
    :   parExpression
    |   qualifiedName
    /*|   qualifiedName LT expression */
    /*|   qualifiedName DOT CLASS*/
    |   qualifiedName DOT CLASS
    |   expression DOT qualifiedName
    |   expression DOT SUPER
    |   qualifiedName DOT SUPER
    |   qualifiedName DOT SUPER DOT expression
    |   expression DOT SUPER DOT expression
    |   expression DOT SUPER arguments
    |   expression DOT SUPER LPAREN RPAREN
    |   expression
    |   qualifiedName DOT newCreator
    |   expression DOT newCreator /* openjdk/jdk/src/share/classes/com/sun/java/util/jar/pack/Attribute.java:487 */
    |   qualifiedName arrayDimensionBrackl DOT CLASS
    |   primitiveType DOT CLASS
    /*|   type DOT CLASS*/
    |   primitiveType arrayDimensionBrackl DOT CLASS
    |   qualifiedName DOT THIS
    |   expression DOT THIS
    |   expression DOT NEW optionalNonWildcardTypeArguments innerCreator
    |   qualifiedName DOT explicitGenericInvocation
    |   expression DOT qualifiedName
    |   expression DOT typeParameters Identifier arguments
    |   expression LBRACK expression RBRACK
    |   qualifiedName LBRACK expression RBRACK
    |   expression arguments
    |   expression LPAREN RPAREN
    |   newCreator
    |   parExpression expression

    /*|   typeCast expression*/
    /*|   typeCast DOT qualifiedName*/
    |   expression incrementOrDecrement
    |   plusMinusIncOrDec expression
    |   prefixTildeOrBang expression
    |   expression mulDivOrMod expression
    |   expression addOrSub expression
    |   expression LSHIFT expression
    |   expression GT GT expression
    |   expression GT GT GT expression
    |   expression lE_GE_LT_GT expression
    |   expression INSTANCEOF type
    |   expression equals_NotEqual expression
    |   expression BITAND expression
    |   expression CARET expression
    |   expression BITOR expression
    |   expression AND expression
    |   expression OR expression
    |   expression QUESTION expression COLON expression
    |   expression assignmentToken expression
    |   THIS
    |   SUPER
    |   IntegerLiteral
    |   FloatingPointLiteral
    |   CharacterLiteral
    |   StringLiteral
    |   BooleanLiteral
    |   NullLiteral
    |   VOID DOT CLASS
    |   nonWildcardTypeArguments explicitGenericInvocationSuffixOrThisArgs
    ;

parExpression
    :   LPAREN primitiveType RPAREN
    |   LPAREN qualifiedName arrayDimensionBrackl RPAREN
    |   LPAREN qualifiedName typeParameters arrayDimensionBrackl RPAREN
    |   LPAREN qualifiedName typeParameters RPAREN
    |   LPAREN primitiveType arrayDimensionBrackl RPAREN
    |   LPAREN expression RPAREN /* All except this are type casts */
    /*|   parExpression*/
    /*|   LPAREN qualifiedName LSHIFT expression RPAREN
    |   LPAREN qualifiedName GT GT GT expression RPAREN
    |   LPAREN qualifiedName GT GT expression RPAREN*/
    ;

explicitGenericInvocationSuffixOrThisArgs
    :   explicitGenericInvocationSuffix
    |   THIS arguments
    ;

creator
    :   nonWildcardTypeArguments createdName classCreatorRest
    |   createdName arrayOrClassCreator
    ;

arrayOrClassCreator
    :   arrayCreatorRest
    |   classCreatorRest
    ;

createdName
    :   qualifiedName optionalTypeArgumentsOrDiamonds
    |   primitiveType
    ;

optionalTypeArgumentsOrDiamonds
    :   %empty /* empty */
    |   typeArgumentsOrDiamondList
    ;

typeArgumentsOrDiamondList
    :   typeArgumentsOrDiamond
    |   typeArgumentsOrDiamondList DOT Identifier  typeArgumentsOrDiamond
    ;

innerCreator
    :   Identifier optionalNonWildcardTypeArgumentsOrDiamond classCreatorRest
    ;

optionalNonWildcardTypeArgumentsOrDiamond
    :   %empty /* empty */
    |   nonWildcardTypeArgumentsOrDiamond
    ;
arrayCreatorRest
    :   LBRACK RBRACK arrayDimensionBracks arrayInitializer
    |   bracketedExpressions arrayDimensionBracks
    ;

bracketedExpressions
    :   LBRACK expression RBRACK
    |   bracketedExpressions LBRACK expression RBRACK
    ;

classCreatorRest
    :   arguments
    |   LPAREN RPAREN
    |   LPAREN RPAREN classBody
    |   arguments classBody
    ;

optionalClassBody
    :   %empty /* empty */
    |   classBody
    ;

explicitGenericInvocation
    :   nonWildcardTypeArguments explicitGenericInvocationSuffix
    ;

nonWildcardTypeArguments
    :  TEMPLATE
    ;

typeArgumentsOrDiamond
    :   LT GT
    |   typeParameters
    ;

nonWildcardTypeArgumentsOrDiamond
    :   LT GT
    |   nonWildcardTypeArguments
    ;

superSuffix
    :   arguments
    |   DOT Identifier
    |   DOT Identifier arguments
    ;

optionalArguments
    :   %empty /* empty */
    |   arguments
    ;

explicitGenericInvocationSuffix
    :   SUPER superSuffix
    |   Identifier arguments
    ;

arguments
    :   LPAREN RPAREN
    |   LPAREN expressionList RPAREN
    ;

optionalCOMMA
    :   %empty /* empty */
    |   COMMA
    ;