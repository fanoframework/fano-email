(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
unit SendMailController;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano;

type

    (*!-----------------------------------------------
     * controller that handle route :
     * /sendmail
     *
     * See Routes/SendMail/routes.inc
     *
     * @author [[AUTHOR_NAME]] <[[AUTHOR_EMAIL]]>
     *------------------------------------------------*)
    TSendMailController = class(TController)
    private
        fMailer : IMailer;
    public
        constructor create(
            const aview : IView;
            const aviewParams : IViewParameters;
            const mailer : IMailer
        );
        destructor destroy(); override;
        function handleRequest(
            const request : IRequest;
            const response : IResponse;
            const args : IRouteArgsReader
        ) : IResponse; override;
    end;

implementation

uses
    sysutils;

    constructor TSendMailController.create(
        const aview : IView;
        const aviewParams : IViewParameters;
        const mailer : IMailer
    );
    begin
        inherited create(aview, aviewParams);
        fMailer := mailer;
    end;

    destructor TSendMailController.destroy();
    begin
        fMailer := nil;
        inherited destroy();
    end;

    function TSendMailController.handleRequest(
        const request : IRequest;
        const response : IResponse;
        const args : IRouteArgsReader
    ) : IResponse;
    begin
        fMailer.recipientName := request.getParam('name');
        fMailer.recipient := request.getParam('to');
        fMailer.sender := 'no-reply@email.fano';
        fMailer.subject := request.getParam('subject');
        fMailer.body := request.getParam('message');
        if fMailer.send() then
        begin
            viewParams['mailTo'] := fMailer.recipient;
            inherited handleRequest(request, response, args);
        end else
        begin
            raise Exception.create('Fail to send email');
        end;
        result := response;
    end;

end.
