(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit SendMailViewFactory;

interface

{$MODE OBJFPC}
{$H+}

uses
    fano;

type

    (*!-----------------------------------------------
     * Factory for view TSendMailView
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TSendMailViewFactory = class(TFactory)
    public
        function build(const container : IDependencyContainer) : IDependency; override;
    end;

implementation

uses

    SysUtils

    {*! -------------------------------
        unit interfaces
    ----------------------------------- *};

    function TSendMailViewFactory.build(const container : IDependencyContainer) : IDependency;
    var freader : IFileReader;
        parser : ITemplateParser;
    begin
        freader := container['fileReader'] as IFileReader;
        parser := container['tplParser'] as ITemplateParser;
        result := TView.create(
            parser,
            fReader.readFile(
                getCurrentDir() + '/resources/Templates/Mail/index.html'
            )
        );
    end;
end.
