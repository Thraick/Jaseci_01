import {*} with './edges.jac';
import {*} with './globals.jac';
import {*} with './nodes.jac';

graph dialogue_system {
    has anchor dialogue_root;
    spawn {
        dialogue_root = spawn node::dialogue_root;
        global.dialogue_root = dialogue_root.info['jid'];

        soc = spawn node::soc;
        dialogue_root -[intent_transition(intent="greetings")]->soc;

        eoc = spawn node::eoc;
        dialogue_root -[intent_transition(intent="goodbye")]->eoc;

        faq_root = spawn node::faq_root;
        dialogue_root -[intent_transition(intent="faq_root")]->faq_root;


        // tes = spawn node::tes;
        // dialogue_root -[entity_transition(entities=["date"])]->tes;

        // tes2 = spawn node::tes;
        // dialogue_root -[entity_transition(entities=["date","time"])]->tes2;


        // tes1 = spawn node::tes;
        // dialogue_root -[entity_transition(entities=["number"])]->tes1;

        account = spawn node::account;
        number = spawn node::number;

        dialogue_root -[intent_transition(intent="account")]->account;

        account -[redirect_transition(name="number")]->number;
        // account -[intent_transition(intent="dialogue_root")]->dialogue_root;

        number -[intent_transition(intent="number")]->number;
        number -[entity_transition(entities=["number"])]->account;
        number -[intent_transition(intent="faq_root")]->faq_root;




    }
}