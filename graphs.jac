import {*} with './edges.jac';
import {*} with './globals.jac';
import {*} with './nodes.jac';

graph dialogue_system {
    has anchor dialogue_root;
    spawn {
        bienc = file.load_json(global.bi_enc_path);
        

        dialogue_root = spawn node::dialogue_root;
        global.dialogue_root = dialogue_root.info['jid'];

        soc = spawn node::soc(imprint = {"list_imprint":bienc['greetings'], "name": "greetings"});
        dialogue_root -[intent_transition(intent="greetings")]->soc;

        eoc = spawn node::eoc(imprint = {"list_imprint":bienc['goodbye'], "name": "goodbye"});
        dialogue_root -[intent_transition(intent="goodbye")]->eoc;

        faq_root = spawn node::faq_root(imprint = {"list_imprint":bienc['faq_root'], "name": "faq_root"});
        dialogue_root -[intent_transition(intent="faq_root")]->faq_root;

        account = spawn node::account(imprint = {"list_imprint":bienc['account'], "name": "account"});
        number = spawn node::number;

        dialogue_root -[intent_transition(intent="account")]->account;

        account -[redirect_transition(name="number")]->number;

        number -[intent_transition(intent="number")]->number;
        number -[entity_transition(entities=["number"])]->account;
        number -[intent_transition(intent="faq_root")]->faq_root;




    }
}